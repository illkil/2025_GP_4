import { auth, db } from "./firebase-init.js";
import {
  onAuthStateChanged,
  signOut
} from "https://www.gstatic.com/firebasejs/12.4.0/firebase-auth.js";
import { doc, getDoc, updateDoc } from "https://www.gstatic.com/firebasejs/12.4.0/firebase-firestore.js";

// العناصر من الصفحة
const nameInProfile = document.querySelector(".pname");
const welcomeName = document.getElementById("hiName"); // ✅ بدون #
const profileImage = document.querySelector(".profile img");
const langButton = document.getElementById("ppLang");
const logoutButton = document.getElementById("ppLogout");

//تحميل القيم المخزّنة محلياً (فوري)
const cachedName = localStorage.getItem("first_name");
const cachedPhoto = localStorage.getItem("profile_photo");
const cachedLang = localStorage.getItem("lang");

//عرض البيانات مباشرة من التخزين المحلي لتسريع التحميل
if (cachedName && nameInProfile) nameInProfile.textContent = cachedName;
if (cachedName && welcomeName) welcomeName.textContent = cachedName + "!";
if (cachedPhoto && profileImage) profileImage.src = cachedPhoto;

//تطبيق اللغة المحفوظة (حتى قبل Firebase)
if (cachedLang) {
  loadLanguage(cachedLang);
  if (langButton)
    langButton.querySelector("span:last-child").textContent =
      cachedLang === "ar" ? "العربية" : "English";
}

// متابعة حالة المستخدم من Firebase
onAuthStateChanged(auth, async (user) => {
  if (user) {
    try {
      const docRef = doc(db, "users", user.uid);
      const docSnap = await getDoc(docRef);

      if (docSnap.exists()) {
        const data = docSnap.data();

        const firstName = data.first_name?.trim() || "Admin";
        const photoURL = data.profile_pic || "Images/ProfilePic.jpg";
        const userLang = data.language || cachedLang || "en";

        //  تحديث الواجهة
        if (nameInProfile) nameInProfile.textContent = firstName;
        if (welcomeName) welcomeName.textContent = firstName + "!";
        if (profileImage) profileImage.src = photoURL;
        if (langButton)
          langButton.querySelector("span:last-child").textContent =
            userLang === "ar" ? "العربية" : "English";

        //  حفظها محليًا
        localStorage.setItem("first_name", firstName);
        localStorage.setItem("profile_photo", photoURL);
        localStorage.setItem("lang", userLang);

        //  تطبيق اللغة
        loadLanguage(userLang);
      } else {
        console.warn("User document not found in Firestore.");
        if (nameInProfile) nameInProfile.textContent = "Admin";
        if (welcomeName) welcomeName.textContent = "Admin!";
      }
    } catch (error) {
      console.error("Error loading user data:", error);
      if (nameInProfile) nameInProfile.textContent = "Admin";
      if (welcomeName) welcomeName.textContent = "Admin!";
    }
  } else {
    //  المستخدم غير مسجل دخول
    localStorage.clear();
    window.location.href = "Sign-In.html";
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
      const userRef = doc(db, "users", user.uid);
      await updateDoc(userRef, { language: newLang });
      console.log("Language updated in Firestore:", newLang);
    } catch (err) {
      console.error("Error updating language:", err);
    }
  }
});

//  تسجيل الخروج
logoutButton?.addEventListener("click", async () => {
  const confirmed = confirm(
    localStorage.getItem("lang") === "ar"
      ? "هل أنت متأكد أنك تريد تسجيل الخروج؟"
      : "Are you sure you want to log out?"
  );
  if (confirmed) {
    await signOut(auth);
    localStorage.clear();
    window.location.href = "Sign-In.html";
  }
});
