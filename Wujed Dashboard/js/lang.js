let currentTranslations = {}; // نحفظ الترجمة الحالية هنا

// تحميل اللغة من ملف JSON
async function loadLanguage(lang) {
  try {
    const response = await fetch(`./lang/${lang}.json`);
    const translations = await response.json();

    currentTranslations = translations; // حفظ الترجمة الحالية
    
    // غيّر كل العناصر اللي فيها data-i18n
    for (const key in translations) {
      const elements = document.querySelectorAll(`[data-i18n="${key}"]`);
      elements.forEach(el => el.textContent = translations[key]);
    }

    // غيّر اتجاه الصفحة حسب اللغة
    document.body.dir = lang === "ar" ? "rtl" : "ltr";
    document.body.style.fontFamily = lang === "ar"
      ? "'Segoe UI', Tahoma, sans-serif"
      : "'Segoe UI', Arial, sans-serif";

    // حفظ اللغة الحالية في LocalStorage
    localStorage.setItem("lang", lang);

    // تحديث زر اللغة
    const btn = document.getElementById("langBtn");
    if (btn) btn.textContent = lang === "ar" ? "EN" : "AR";

    // نحفظ اللغة الحالية عالمياً
    window.currentLang = lang;

  } catch (err) {
    console.error("Error loading language:", err);
  }
}

// 🔁 تحديث الترجمة للعناصر الجديدة بعد تحميل الصفحة
function updateTranslations() {
  for (const key in currentTranslations) {
    const elements = document.querySelectorAll(`[data-i18n="${key}"]`);
    elements.forEach(el => el.textContent = currentTranslations[key]);
  }
}

// التبديل بين اللغتين
function switchLanguage() {
  const current = localStorage.getItem("lang") || "en";
  const newLang = current === "en" ? "ar" : "en";
  loadLanguage(newLang);
}

// تحميل اللغة عند فتح الصفحة
window.addEventListener("DOMContentLoaded", () => {
  const savedLang = localStorage.getItem("lang") || "en";
  loadLanguage(savedLang);
});
