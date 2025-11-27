let currentTranslations = {}; // save current translations here

// Load language from JSON file
async function loadLanguage(lang) {
  try {
    const response = await fetch(`./lang/${lang}.json`);
    const translations = await response.json();

    currentTranslations = translations; // حفظ الترجمة الحالية
    
    // Change all elements with data-i18n attribute
    for (const key in translations) {
      const elements = document.querySelectorAll(`[data-i18n="${key}"]`);
      elements.forEach(el => el.textContent = translations[key]);
    }

    // Change page direction based on language
    document.body.dir = lang === "ar" ? "rtl" : "ltr";
    document.body.style.fontFamily = lang === "ar"
      ? "'Segoe UI', Tahoma, sans-serif"
      : "'Segoe UI', Arial, sans-serif";

    // Save current language in LocalStorage
    localStorage.setItem("lang", lang);

    // Update language button
    const btn = document.getElementById("langBtn");
    if (btn) btn.textContent = lang === "ar" ? "EN" : "AR";

    // Save current language globally
    window.currentLang = lang;

  } catch (err) {
    console.error("Error loading language:", err);
  }
}

//  Update translations for new elements after page load
function updateTranslations() {
  for (const key in currentTranslations) {
    const elements = document.querySelectorAll(`[data-i18n="${key}"]`);
    elements.forEach(el => el.textContent = currentTranslations[key]);
  }
}

// Switch between languages
function switchLanguage() {
  const current = localStorage.getItem("lang") || "en";
  const newLang = current === "en" ? "ar" : "en";
  loadLanguage(newLang);
}

// Load language on page load
window.addEventListener("DOMContentLoaded", () => {
  const savedLang = localStorage.getItem("lang") || "en";
  loadLanguage(savedLang);
});
