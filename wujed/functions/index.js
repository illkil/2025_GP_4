const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.resetUserPassword = functions.https.onCall(async (data, context) => {
  const email = data.email;
  const newPassword = data.newPassword;

  try {
    const user = await admin.auth().getUserByEmail(email);
    await admin.auth().updateUser(user.uid, {password: newPassword});

    return {success: true};
  } catch (error) {
    throw new functions.https.HttpsError("unknown", error.message);
  }
});
