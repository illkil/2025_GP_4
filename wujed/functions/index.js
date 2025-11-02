const {onCall} = require("firebase-functions/v2/https");
const admin = require("firebase-admin");

admin.initializeApp();

exports.resetUserPassword = onCall(async (request) => {
  const email = request.data.email;
  const newPassword = request.data.newPassword;

  if (!email || !newPassword) {
    throw new Error("Missing email or password");
  }

  try {
    // Get the user by email
    const user = await admin.auth().getUserByEmail(email);

    // Update their password
    await admin.auth().updateUser(user.uid, {password: newPassword});

    return {success: true, message: "Password reset successfully"};
  } catch (error) {
    console.error("Error resetting password:", error);
    throw new Error(error.message);
  }
});
