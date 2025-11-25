// firebase-init.js

self.FIREBASE_APPCHECK_DEBUG_TOKEN = "8A9D2C98-F2E8-4276-932E-1309E90C1801"; //TO BE REMOVED IN THE FUTURE

import { initializeApp } from "https://www.gstatic.com/firebasejs/12.4.0/firebase-app.js";
import { getAnalytics } from "https://www.gstatic.com/firebasejs/12.4.0/firebase-analytics.js";
import { getAuth } from "https://www.gstatic.com/firebasejs/12.4.0/firebase-auth.js";
import { getFirestore } from "https://www.gstatic.com/firebasejs/12.4.0/firebase-firestore.js";
import { initializeAppCheck, ReCaptchaV3Provider } 
from "https://www.gstatic.com/firebasejs/12.4.0/firebase-app-check.js";

const firebaseConfig = {
  apiKey: "AIzaSyDbJL2avV8tXAukcG4eK0mQUBT6BkzivCQ",
  authDomain: "wujed-379c7.firebaseapp.com",
  projectId: "wujed-379c7",
  storageBucket: "wujed-379c7.firebasestorage.app",
  messagingSenderId: "1031003478013",
  appId: "1:1031003478013:web:48237a78e5f8d0724d6b94",
  measurementId: "G-PVCT9CJGRG"
};

const app = initializeApp(firebaseConfig);
const appCheck = initializeAppCheck(app, {
  provider: new ReCaptchaV3Provider("6LfJShgsAAAAABlOMMfosMsbF0y-N_2BmNBdzziC"),
  isTokenAutoRefreshEnabled: true,
});

const analytics = getAnalytics(app);
const auth = getAuth(app);
const db = getFirestore(app);

// export to use in other scripts
export { app, analytics, auth, db };
