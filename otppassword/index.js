const functions = require("firebase-functions");
const admin = require("firebase-admin");
const nodemailer = require("nodemailer");

admin.initializeApp();
const db = admin.firestore();

// ✅ 1. Email sender setup (replace with your Gmail and App Password)
const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "neath5738@gmail.com",            // replace with your Gmail
    pass: "nxii sshl okwy gaqo",         // replace with your Gmail App Password
  },
});

// ✅ 2. Generate and send OTP
exports.sendOtp = functions.https.onCall(async (data, context) => {
  const email = data.email;

  if (!email || !email.includes("@")) {
    throw new functions.https.HttpsError("invalid-argument", "Invalid email.");
  }

  const otp = Math.floor(100000 + Math.random() * 900000).toString();
  const expiresAt = admin.firestore.Timestamp.fromDate(
    new Date(Date.now() + 5 * 60 * 1000) // 5 minutes
  );

  await db.collection("password_resets").doc(email).set({
    otp,
    expires_at: expiresAt,
  });

  await transporter.sendMail({
    from: '"Smart Ey Smart Yang Nis" neath5738@gmail.com',
    to: email,
    subject: "Your OTP Code",
    text: `Your OTP is: ${otp}. It will expire in 5 minutes.`,
  });

  return { success: true };
});

// ✅ 3. Verify OTP
exports.verifyOtp = functions.https.onCall(async (data, context) => {
  const { email, otp } = data;

  const doc = await db.collection("password_resets").doc(email).get();
  if (!doc.exists) throw new functions.https.HttpsError("not-found", "OTP not found");

  const { otp: storedOtp, expires_at } = doc.data();
  const now = admin.firestore.Timestamp.now();

  if (storedOtp !== otp) {
    throw new functions.https.HttpsError("invalid-argument", "Incorrect OTP");
  }

  if (now.toMillis() > expires_at.toMillis()) {
    throw new functions.https.HttpsError("deadline-exceeded", "OTP expired");
  }

  return { valid: true };
});

// ✅ 4. Reset password
exports.resetPassword = functions.https.onCall(async (data, context) => {
  const { email, otp, newPassword } = data;

  const doc = await db.collection("password_resets").doc(email).get();
  if (!doc.exists) throw new functions.https.HttpsError("not-found", "OTP not found");

  const { otp: storedOtp, expires_at } = doc.data();
  const now = admin.firestore.Timestamp.now();

  if (storedOtp !== otp) {
    throw new functions.https.HttpsError("invalid-argument", "Incorrect OTP");
  }

  if (now.toMillis() > expires_at.toMillis()) {
    throw new functions.https.HttpsError("deadline-exceeded", "OTP expired");
  }

  const user = await admin.auth().getUserByEmail(email);
  await admin.auth().updateUser(user.uid, { password: newPassword });

  await db.collection("password_resets").doc(email).delete();

  return { success: true };
});
