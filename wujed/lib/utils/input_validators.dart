// lib/utils/input_validators.dart
//
// This file contains all reusable validation + sanitizing logic
// for Wujed text inputs (signup, login, reports, etc.).
//
// We keep everything here so:
//  - the rules are consistent across the whole app
//  - the code in the UI pages stays clean and short

import 'package:flutter/material.dart';

/// A utility class that contains static methods only.
/// We never create an object from this class, we just call:
///   InputValidators.validateEmail(...);
///   InputValidators.sanitizeText(...);
class InputValidators {
  // ---------------------------------------------------------------------------
  // 1) GENERIC SANITISER
  // ---------------------------------------------------------------------------

  /// Clean up any user input *before* we send it to Firestore or the backend.
  ///
  /// What this function does:
  ///   1) If the input is null -> return empty string (to avoid crashes).
  ///   2) Trim spaces at the beginning and end.
  ///   3) Collapse multiple spaces/tabs/newlines into a single space.
  ///   4) Remove control characters (hidden / non-printable).
  ///   5) Remove characters like < and > (basic protection if text is ever
  ///      rendered inside HTML).
  ///   6) Cut the string to a safe maximum length.
  ///
  /// We can change maxLen depending on the field (name, title, description…).
  static String sanitizeText(String? input, {int maxLen = 500}) {
    if (input == null) {
      // If the text is null, just return empty string.
      return '';
    }

    // 1) Remove spaces at the start and end.
    var text = input.trim();

    // 2) Normalize whitespace: multiple spaces/newlines/tabs -> single space.
    text = text.replaceAll(RegExp(r'\s+'), ' ');

    // 3) Remove invisible control characters (helps avoid weird hidden chars).
    text = text.replaceAll(RegExp(r'[\u0000-\u001F\u007F]'), '');

    // 4) Remove < and >. This is not full XSS protection,
    //    but it's a simple step so we never store raw HTML-like tags.
    text = text.replaceAll(RegExp(r'[<>]'), '');

    // 5) Limit the length so users can’t send super long strings.
    if (text.length > maxLen) {
      text = text.substring(0, maxLen);
    }

    return text;
  }

  // ---------------------------------------------------------------------------
  // 2) VALIDATORS FOR SIGNUP / PROFILE
  // ---------------------------------------------------------------------------

  /// Validate full name.
  ///
  /// Rules:
  ///  - Required (cannot be empty)
  ///  - Max 50 characters
  ///  - Only letters (Arabic + English) and spaces
  static String? validateFullName(String? value) {
    // First sanitize and limit length.
    final text = sanitizeText(value, maxLen: 50);

    // If empty -> show an error message under the TextFormField.
    if (text.isEmpty) {
      return 'Name is required';
    }

    // \p{L} = any kind of letter from any language (unicode: true is important).
    // The regex below means: one or more letters or spaces only.
    final nameRegExp = RegExp(r'^[\p{L} ]+$', unicode: true);

    if (!nameRegExp.hasMatch(text)) {
      // If there are numbers, emojis, or special symbols, this will be returned.
      return 'Name can only contain letters and spaces';
    }

    // Returning null means: "no error, input is valid".
    return null;
  }

  /// Validate email.
  ///
  /// Rules:
  ///  - Required
  ///  - Max 100 characters
  ///  - Must match a simple email pattern: something@something.domain
  static String? validateEmail(String? value) {
    final text = sanitizeText(value, maxLen: 100);

    if (text.isEmpty) {
      return 'Email is required';
    }

    // Simple email regex. This is not perfect, but good enough for our use.
    final emailRegExp = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

    if (!emailRegExp.hasMatch(text)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  /// Validate password.
  ///
  /// Rules:
  ///  - Required
  ///  - At least 8 characters
  ///  - Must contain at least one letter and one digit
  static String? validatePassword(String? value) {
    // We don't use sanitizeText here because we don't want to delete characters
    // from the password, we only trim surrounding spaces.
    final text = (value ?? '').trim();

    if (text.isEmpty) {
      return 'Password is required';
    }

    if (text.length < 8) {
      return 'Password must be at least 8 characters';
    }

    // At least one letter (A–Z or a–z).
    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(text);
    // At least one digit (0–9).
    final hasDigit = RegExp(r'\d').hasMatch(text);

    if (!hasLetter || !hasDigit) {
      return 'Password must contain letters and numbers';
    }

    return null;
  }

  // ---------------------------------------------------------------------------
  // 3) VALIDATORS FOR LOST/FOUND REPORTS
  // ---------------------------------------------------------------------------

  /// Validate report title.
  ///
  /// Example usage: "Lost iPhone 13 at Riyadh Park"
  ///
  /// Rules:
  ///  - Required
  ///  - Min length 3 (to avoid titles like "a")
  ///  - Max length 80
  static String? validateReportTitle(String? value) {
    final text = sanitizeText(value, maxLen: 80);

    if (text.isEmpty) {
      return 'Title is required';
    }

    if (text.length < 3) {
      return 'Title is too short';
    }

    return null;
  }

  /// Validate report description.
  ///
  /// Rules:
  ///  - Required
  ///  - Min length 10 (we want some useful information)
  ///  - Max length 1000 (limit stored text)
  static String? validateReportDescription(String? value) {
    final text = sanitizeText(value, maxLen: 1000);

    if (text.isEmpty) {
      return 'Description is required';
    }

    if (text.length < 10) {
      return 'Please describe the item in more detail';
    }

    return null;
  }

  /// Validate a free-text location (if user types it manually).
  ///
  /// Example: "Riyadh Park, gate 3 near Starbucks"
  ///
  /// Rules:
  ///  - Required
  ///  - Max length 120
  static String? validateLocationText(String? value) {
    final text = sanitizeText(value, maxLen: 120);

    if (text.isEmpty) {
      return 'Location is required';
    }

    return null;
  }

  // ---------------------------------------------------------------------------
  // 4) HELPER FOR DROPDOWNS OR ENUM-LIKE FIELDS
  // ---------------------------------------------------------------------------

  /// Generic validator for dropdown values (e.g., category).
  ///
  /// Usage example:
  ///   validator: (value) =>
  ///       InputValidators.validateRequiredDropdown(value, 'Category is required');
  static String? validateRequiredDropdown(Object? value, String message) {
    // If null -> user didn’t pick anything.
    if (value == null) {
      return message;
    }
    // If it is a String, also check after trimming.
    if (value is String && value.trim().isEmpty) {
      return message;
    }
    return null;
  }
}
