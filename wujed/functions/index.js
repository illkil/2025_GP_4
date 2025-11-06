const {onCall} = require("firebase-functions/v2/https");
const {onDocumentCreated} = require("firebase-functions/v2/firestore");
const admin = require("firebase-admin");
// axios is a library used to send http request to fastApi server
const axios = require("axios");

admin.initializeApp();

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

      // only retry if category is processing or null
      if (data.category != null && data.category != "processing") return;

      // delay retry by 60 seconds
      await new Promise((resolve) => setTimeout(resolve, 20000));

      // send images, description to server
      const res = await axios.post("https://wujed-classifier-1031003478013.us-central1.run.app/classify", {
        image_urls: data.images,
        description: data.description,
      });

      // update category for the firestore document
      await snap.ref.update({
        category: res.data.category,
        updatedAt: new Date(),
      });
    });
