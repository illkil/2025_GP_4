// firebase-init.js
import { initializeApp } from "https://www.gstatic.com/firebasejs/12.4.0/firebase-app.js";
import { getAnalytics } from "https://www.gstatic.com/firebasejs/12.4.0/firebase-analytics.js";
import { getAuth } from "https://www.gstatic.com/firebasejs/12.4.0/firebase-auth.js";
import { getFirestore } from "https://www.gstatic.com/firebasejs/12.4.0/firebase-firestore.js";

const firebaseConfig = {
  apiKey: "AIzaSyCPkVS7MeUx74qLyWXxbs2eFCsciP1LCkw",
  authDomain: "wujed-ffc1f.firebaseapp.com",
  projectId: "wujed-ffc1f",
  storageBucket: "wujed-ffc1f.firebasestorage.app",
  messagingSenderId: "743280664993",
  appId: "1:743280664993:web:d7d8663557e22abaa52be0",
  measurementId: "G-HR41CC0Y84"
};

// 🔹 initialize once
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);
const auth = getAuth(app);
const db = getFirestore(app);

// 🔹 export to use in other scripts
export { app, analytics, auth, db };
