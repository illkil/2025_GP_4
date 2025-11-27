import { auth, db } from "./firebase-init.js";
import {
  onAuthStateChanged,
  signOut
} from "https://www.gstatic.com/firebasejs/12.4.0/firebase-auth.js";
import { doc, getDoc, updateDoc } from "https://www.gstatic.com/firebasejs/12.4.0/firebase-firestore.js";

// Items DOM
const nameInProfile = document.querySelector(".pname");
const welcomeName = document.getElementById("hiName");
const profileImage = document.querySelector(".profile img");
const langButton = document.getElementById("ppLang");
const logoutButton = document.getElementById("ppLogout");

// loadLanguage function and currentTranslations object
const cachedName = localStorage.getItem("first_name");
const cachedPhoto = localStorage.getItem("profile_photo");
const cachedLang = localStorage.getItem("lang");

// Display data directly from cache if available (no flicker)
if (cachedName) {
  if (nameInProfile) nameInProfile.textContent = cachedName;
  if (welcomeName) welcomeName.textContent = cachedName + "!";
}
if (profileImage) {
  profileImage.src = cachedPhoto || "Images/ProfilePic.jpg";
}
if (cachedLang && langButton) {
  loadLanguage(cachedLang);
  langButton.querySelector("span:last-child").textContent =
    cachedLang === "ar" ? "العربية" : "English";
}

// Monitor user state
onAuthStateChanged(auth, async (user) => {
  if (!user) {
    localStorage.clear();
    window.location.href = "Sign-In.html";
    return;
  }

  try {
    const publicDocRef = doc(db, "users", user.uid, "public", "data");
    const publicDocSnap = await getDoc(publicDocRef);

    const privateDocRef = doc(db, "users", user.uid, "private", "data");
    const privateDocSnap = await getDoc(privateDocRef);

    if (!publicDocSnap.exists() || !privateDocSnap.exists()) return;

    const publicData = publicDocSnap.data();
    const privateData = privateDocSnap.data();
    const firstName = privateData.first_name?.trim() || "Admin";
    const photoURL = publicData.profile_photo || "Images/ProfilePic.jpg";
    const userLang = privateData.language || cachedLang || "en";

    // Update page UI (only if elements exist)
    if (nameInProfile) nameInProfile.textContent = firstName;
    if (welcomeName) welcomeName.textContent = firstName + "!";
    if (profileImage) profileImage.src = photoURL;
    if (langButton)
      langButton.querySelector("span:last-child").textContent =
        userLang === "ar" ? "العربية" : "English";

    // Save data to local storage
    localStorage.setItem("first_name", firstName);
    localStorage.setItem("profile_photo", photoURL);
    localStorage.setItem("lang", userLang);

    // Apply language
    loadLanguage(userLang);


    // Check role
    const role = privateData.role || "user";
    if (role !== "admin") {
      localStorage.clear();
      window.location.href = "Wujed.html";
      return;
    }

  } catch (error) {
    console.error("Error loading user data:", error);
  }
});


// Language toggle and Firestore update
langButton?.addEventListener("click", async () => {
  const currentLang = localStorage.getItem("lang") || "en";
  const newLang = currentLang === "en" ? "ar" : "en";

  // Apply language immediately
  loadLanguage(newLang);
  localStorage.setItem("lang", newLang);
  langButton.querySelector("span:last-child").textContent =
    newLang === "ar" ? "العربية" : "English";

  // Update in Firestore
  const user = auth.currentUser;
  if (user) {
    try {
      const userRef = doc(db, "users", user.uid, "private", "data");
      await updateDoc(userRef, { language: newLang });
      console.log("Language updated in Firestore:", newLang);
    } catch (err) {
      console.error("Error updating language:", err);
    }
  }
});


// Logout Modal
const logoutModal = document.getElementById("logoutModal");
const cancelLogout = document.getElementById("cancelLogout");
const confirmLogout = document.getElementById("confirmLogout");

if (logoutButton) {
  logoutButton.addEventListener("click", () => {
    closeProfile();

    // Update message text based on language
    const lang = localStorage.getItem("lang") || "en";
    const msg = lang === "ar" 
      ? "هل أنت متأكد أنك تريد تسجيل الخروج؟" 
      : "Are you sure you want to log out?";
    document.getElementById("logoutMessage").textContent = msg;

    logoutModal.style.display = "flex";
  });
}

// Cancel logout
cancelLogout.addEventListener("click", () => {
  logoutModal.style.display = "none";
});

// Confirm logout
confirmLogout.addEventListener("click", async () => {
  logoutModal.style.display = "none";
  await signOut(auth);
  localStorage.clear();
  window.location.href = "Sign-In.html";
});

// Close modal if user clicks outside content
window.addEventListener("click", (e) => {
  if (e.target === logoutModal) {
    logoutModal.style.display = "none";
  }
});


function closeProfile() {
  const profilePanel = document.getElementById("profilePopover");
  if (profilePanel) profilePanel.classList.remove("show");
};

// Update all elements with data-i18n attribute (including dynamic ones)
function updateTranslations() {
  for (const key in currentTranslations) {
    const elements = document.querySelectorAll(`[data-i18n="${key}"]`);
    elements.forEach(el => el.textContent = currentTranslations[key]);
  }

}
