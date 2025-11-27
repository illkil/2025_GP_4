import { auth, db } from "./firebase-init.js";
import {
  onAuthStateChanged,
  signOut
} from "https://www.gstatic.com/firebasejs/12.4.0/firebase-auth.js";
import { doc, getDoc, updateDoc } from "https://www.gstatic.com/firebasejs/12.4.0/firebase-firestore.js";

// العناصر من الصفحة (لو موجودة)
const nameInProfile = document.querySelector(".pname");
const welcomeName = document.getElementById("hiName");
const profileImage = document.querySelector(".profile img");
const langButton = document.getElementById("ppLang");
const logoutButton = document.getElementById("ppLogout");

// تحميل البيانات من التخزين المحلي
const cachedName = localStorage.getItem("first_name");
const cachedPhoto = localStorage.getItem("profile_photo");
const cachedLang = localStorage.getItem("lang");

// عرض البيانات مباشرة من الكاش لو موجودة (بدون وميض)
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

// متابعة حالة المستخدم
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

    // تحديث واجهة الصفحة (فقط إذا العناصر موجودة)
    if (nameInProfile) nameInProfile.textContent = firstName;
    if (welcomeName) welcomeName.textContent = firstName + "!";
    if (profileImage) profileImage.src = photoURL;
    if (langButton)
      langButton.querySelector("span:last-child").textContent =
        userLang === "ar" ? "العربية" : "English";

    // حفظ البيانات في التخزين المحلي
    localStorage.setItem("first_name", firstName);
    localStorage.setItem("profile_photo", photoURL);
    localStorage.setItem("lang", userLang);

    // تطبيق اللغة
    loadLanguage(userLang);


    // 🔐 التحقق من الدور
    const role = privateData.role || "user";
    if (role !== "admin") {
      localStorage.clear();
      window.location.href = "Sign-In.html";
      return;
    }

  } catch (error) {
    console.error("Error loading user data:", error);
  }
});


//  تبديل اللغة وتحديث Firestore
langButton?.addEventListener("click", async () => {
  const currentLang = localStorage.getItem("lang") || "en";
  const newLang = currentLang === "en" ? "ar" : "en";

  //  تطبيق اللغة فورًا
  loadLanguage(newLang);
  localStorage.setItem("lang", newLang);
  langButton.querySelector("span:last-child").textContent =
    newLang === "ar" ? "العربية" : "English";

  //  تحديث في Firestore
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

    // تحديث نص الرسالة حسب اللغة
    const lang = localStorage.getItem("lang") || "en";
    const msg = lang === "ar" 
      ? "هل أنت متأكد أنك تريد تسجيل الخروج؟" 
      : "Are you sure you want to log out?";
    document.getElementById("logoutMessage").textContent = msg;

    logoutModal.style.display = "flex";
  });
}

// إلغاء تسجيل الخروج
cancelLogout.addEventListener("click", () => {
  logoutModal.style.display = "none";
});

// تأكيد تسجيل الخروج
confirmLogout.addEventListener("click", async () => {
  logoutModal.style.display = "none";
  await signOut(auth);
  localStorage.clear();
  window.location.href = "Sign-In.html";
});

// إغلاق الـ Modal إذا ضغط المستخدم خارج المحتوى
window.addEventListener("click", (e) => {
  if (e.target === logoutModal) {
    logoutModal.style.display = "none";
  }
});


function closeProfile() {
  const profilePanel = document.getElementById("profilePopover");
  if (profilePanel) profilePanel.classList.remove("show");
};

// تحديث كل العناصر اللي فيها data-i18n (يشمل الديناميكية)
function updateTranslations() {
  for (const key in currentTranslations) {
    const elements = document.querySelectorAll(`[data-i18n="${key}"]`);
    elements.forEach(el => el.textContent = currentTranslations[key]);
  }

}
