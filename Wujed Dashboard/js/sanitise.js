// js/sanitise.js

function normaliseText(str) {
  return str.replace(/\s+/g, " ").trim();
}

function containsDangerousContent(str) {
  const lower = str.toLowerCase();

  if (
    lower.includes("<script") ||
    lower.includes("</script") ||
    lower.includes("javascript:") ||
    lower.includes("onerror=") ||
    lower.includes("onload=")
  ) {
    return true;
  }

  // Simple HTML tag pattern like <div>, </p>, <img ...>
  if (/<\/?[a-z][^>]*>/i.test(str)) {
    return true;
  }

  return false;
}

function sanitiseTextInput(value, maxLen = 500) {
  if (typeof value !== "string") {
    return { ok: false, error: "Invalid input" };
  }

  let cleaned = normaliseText(value);

  if (cleaned.length === 0) {
    return { ok: false, error: "Field cannot be empty" };
  }

  if (cleaned.length > maxLen) {
    return { ok: false, error: `Maximum length is ${maxLen} characters` };
  }

  if (containsDangerousContent(cleaned)) {
    return {
      ok: false,
      error: "Input contains forbidden HTML/script content",
    };
  }

  return { ok: true, value: cleaned };
}
