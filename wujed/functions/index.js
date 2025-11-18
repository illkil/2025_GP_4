const {onCall} = require("firebase-functions/v2/https");
const {onDocumentCreated} = require("firebase-functions/v2/firestore");
const admin = require("firebase-admin");
// axios is a library used to send http request to fastApi server
const axios = require("axios");

admin.initializeApp();

exports.setUserRole = onDocumentCreated("users/{user_id}", async (event) => {
  const userID = event.params.user_id;

  await admin.firestore().collection("users").doc(userID).update({
    role: "user",
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
