/* eslint-disable max-len */
/* eslint-disable no-unused-vars */

const {onCall} = require("firebase-functions/v2/https");
const {onRequest} = require("firebase-functions/v2/https");
const {onDocumentCreated} = require("firebase-functions/v2/firestore");
const admin = require("firebase-admin");
const cors = require("cors")({origin: true});
// axios is a library used to send http request to fastApi server
const axios = require("axios");
const crypto = require("crypto");

admin.initializeApp();

exports.setUserRole = onDocumentCreated("users/{user_id}/private/data",
    async (event) => {
      const userID = event.params.user_id;

      await admin.firestore().collection("users").doc(userID)
          .collection("private").doc("data").update({
            role: "user",
          });
    });

exports.checkAdminEmail = onRequest((req, res) => {
  cors(req, res, async () => {
    if (req.method !== "POST") {
      return res.status(405).send({error: "Method not allowed"});
    }

    const email = req.body && req.body.email ?
  req.body.email.toLowerCase() :
  null;

    if (!email) {
      return res.status(400).send({exists: false, error: "Missing email"});
    }

    try {
      const privateDocs = await admin.firestore()
          .collectionGroup("private")
          .where("email", "==", email)
          .where("role", "==", "admin")
          .get();

      return res.send({exists: !privateDocs.empty});
    } catch (error) {
      console.error("Error:", error);
      return res.status(500).send({exists: false});
    }
  });
});


exports.resetUserPassword = onCall(async (request) => {
  const email = request.data.email;
  const newPassword = request.data.newPassword;

  if (!email || !newPassword) {
    throw new Error("Missing email or password");
  }

  try {
    // get the user by email
    const user = await admin.auth().getUserByEmail(email);

    // update their password
    await admin.auth().updateUser(user.uid, {password: newPassword});

    return {success: true, message: "Password reset successfully"};
  } catch (error) {
    console.error("Error resetting password:", error);
    throw new Error(error.message);
  }
});

// creating new cloud function named retryClassification
// runs this function automatically whenever a new report is created
exports.retryClassification = onDocumentCreated(
    // firebase watching reports collection, {reportId} means
    // it runs for any document in the collection
    "reports/{reportId}",
    // snap is the new report document data extracted from event
    // event contains the firebase document snapshot and metadata like reportId
    async (event) => {
      const snap = event.data;
      // extract the report attributes
      const data = snap.data();

      // Flutter already rejected or completed the report
      if (data.status === "rejected" || data.status === "done") return;

      // Flutter already assigned a reason — do NOT overwrite it
      if (data.rejectReason != null) return;

      // Do not retry if Flutter already classified it
      if (data.category != null) return;


      // delay retry by 60 seconds to make some time
      // for report images/data to upload first
      // delay retry by 60 seconds
      await new Promise((resolve) => setTimeout(resolve, 60000));

      // check again after the delay in case the category
      // selection was successful during the delay
      const freshSnap = await snap.ref.get();
      const freshData = freshSnap.data();
      if (freshData.category != null || freshData.status === "rejected") return;


      // send images, description to server
      const res = await axios.post("https://wujed-classifier-1031003478013.us-central1.run.app/classify", {
        title: data.title,
        type: data.type,
        image_urls: data.images,
        description: data.description,
      });

      // accepted/rejected logic
      const accepted = res.data.accepted === true;
      const reason = res.data.reason || null;
      const category = res.data.category || null;

      if (!accepted) {
        // classifier rejected the report
        await snap.ref.update({
          status: "rejected",
          rejectReason: reason,
          updatedAt: new Date(),
        });
        return;
      }

      // accepted → update category (if any)
      await snap.ref.update({
        category: category,
        updatedAt: new Date(),
      });
    });


// /////////////////////////////////////////////////////////////// ( WUJED DASHBOARD START ) /////////////////////////////////////////////////////////////////

// OTP Settings
const OTP_COLLECTION = "password_reset_otps";
const OTP_TTL_MS = 10 * 60 * 1000; // 10 minutes
const OTP_MAX_ATTEMPTS = 5;

exports.requestPasswordResetOtp = onCall(async (request) => {
  const emailRaw = (request.data && request.data.email) || "";
  const email = emailRaw.toLowerCase().trim();

  if (!email || !email.includes("@")) {
    throw new Error("Invalid email");
  }

  // Check if user exists (avoid sending OTP to unknown emails)
  let userRecord;
  try {
    userRecord = await admin.auth().getUserByEmail(email);
  } catch (err) {
    // Don't leak info — pretend success
    return {success: true};
  }

  // Generate 6-digit OTP
  const otp = Math.floor(100000 + Math.random() * 900000).toString();

  // Hash OTP before storing
  const otpHash = crypto.createHash("sha256").update(otp).digest("hex");

  const expiresAt = Date.now() + OTP_TTL_MS;

  // Store OTP record
  await admin.firestore().collection(OTP_COLLECTION).doc(email).set({
    email,
    otpHash,
    expiresAt,
    attempts: 0,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  // TODO: Replace this with real email sending (SendGrid/Nodemailer/etc.)
  console.log(`Generated OTP for ${email}: ${otp}`);

  return {success: true};
});

exports.verifyPasswordResetOtp = onCall(async (request) => {
  const emailRaw = (request.data && request.data.email) || "";
  const otpRaw = (request.data && request.data.otp) || "";

  const email = emailRaw.toLowerCase().trim();
  const otp = otpRaw.trim();

  if (!email || !otp || otp.length !== 6) {
    throw new Error("Invalid arguments");
  }

  const docRef = admin.firestore().collection(OTP_COLLECTION).doc(email);
  const snap = await docRef.get();

  if (!snap.exists) {
    return {valid: false, reason: "not_found"};
  }

  const data = snap.data();
  const now = Date.now();

  // OTP expired?
  if (now > data.expiresAt) {
    await docRef.delete();
    return {valid: false, reason: "expired"};
  }

  // Too many failed attempts?
  const attempts = data.attempts || 0;
  if (attempts >= OTP_MAX_ATTEMPTS) {
    await docRef.delete();
    return {valid: false, reason: "too_many_attempts"};
  }

  // Compare hash
  const otpHash = crypto.createHash("sha256").update(otp).digest("hex");
  if (otpHash !== data.otpHash) {
    await docRef.update({attempts: attempts + 1});
    return {valid: false, reason: "mismatch"};
  }

  // Success — delete OTP
  await docRef.delete();

  return {valid: true};
});


// /////////////////////////////////////////////////////////////// ( WUJED DASHBOARD END ) /////////////////////////////////////////////////////////////////
