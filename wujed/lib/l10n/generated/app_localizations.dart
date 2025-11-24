import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @intro1_title_part1.
  ///
  /// In en, this message translates to:
  /// **'Welcome to '**
  String get intro1_title_part1;

  /// No description provided for @intro1_title_part2.
  ///
  /// In en, this message translates to:
  /// **'Wujed'**
  String get intro1_title_part2;

  /// No description provided for @intro1_description.
  ///
  /// In en, this message translates to:
  /// **'Every lost item has a way back home. With\nWujed, you can find what’s missing or help\nreturn what’s found.'**
  String get intro1_description;

  /// No description provided for @intro2_title_part1.
  ///
  /// In en, this message translates to:
  /// **'We’ll help you '**
  String get intro2_title_part1;

  /// No description provided for @intro2_title_part2.
  ///
  /// In en, this message translates to:
  /// **'find it'**
  String get intro2_title_part2;

  /// No description provided for @intro2_description.
  ///
  /// In en, this message translates to:
  /// **'Simply report what’s lost or found, and Wujed’s\nAI works to bring people and their belongings\nback together.'**
  String get intro2_description;

  /// No description provided for @intro3_title_part1.
  ///
  /// In en, this message translates to:
  /// **'Your part '**
  String get intro3_title_part1;

  /// No description provided for @intro3_title_part2.
  ///
  /// In en, this message translates to:
  /// **'matters'**
  String get intro3_title_part2;

  /// No description provided for @intro3_description.
  ///
  /// In en, this message translates to:
  /// **'Your reports help someone find what they’ve\nlost and together, we make a difference.'**
  String get intro3_description;

  /// No description provided for @login_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get login_title;

  /// No description provided for @login_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Please Log in to continue'**
  String get login_subtitle;

  /// No description provided for @login_email_label.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get login_email_label;

  /// No description provided for @login_password_label.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get login_password_label;

  /// No description provided for @login_forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get login_forgot_password;

  /// No description provided for @login_button.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get login_button;

  /// No description provided for @login_no_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get login_no_account;

  /// No description provided for @login_signup_link.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get login_signup_link;

  /// No description provided for @common_or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get common_or;

  /// No description provided for @google_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get google_continue;

  /// No description provided for @login_error_fill_all.
  ///
  /// In en, this message translates to:
  /// **'Please fill all the details'**
  String get login_error_fill_all;

  /// No description provided for @login_error_invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get login_error_invalid;

  /// No description provided for @login_error_too_many_attepmts.
  ///
  /// In en, this message translates to:
  /// **'Too many log in attempts\nPlease try again in 3 minutes'**
  String get login_error_too_many_attepmts;

  /// No description provided for @login_error_failed.
  ///
  /// In en, this message translates to:
  /// **'Login failed, Please try again'**
  String get login_error_failed;

  /// No description provided for @login_locked.
  ///
  /// In en, this message translates to:
  /// **'Please wait {remaining} seconds before trying again'**
  String login_locked(int remaining);

  /// No description provided for @login_email_not_verified.
  ///
  /// In en, this message translates to:
  /// **'Email is not verified'**
  String get login_email_not_verified;

  /// No description provided for @login_email_verification_message.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a verification link to your email.\nPlease check your inbox and click the link to verify your email before logging in.\nIf you don\'t see it in your inbox, check your Spam or Junk folder.\n\nIf you didn\'t receive it or it expired, press Resend. If you got it, press Continue.'**
  String get login_email_verification_message;

  /// No description provided for @login_btn_resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get login_btn_resend;

  /// No description provided for @signup_title.
  ///
  /// In en, this message translates to:
  /// **'Join Us!'**
  String get signup_title;

  /// No description provided for @signup_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Fill all the details to create your account'**
  String get signup_subtitle;

  /// No description provided for @signup_username_label.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get signup_username_label;

  /// No description provided for @signup_email_label.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get signup_email_label;

  /// No description provided for @signup_password_label.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get signup_password_label;

  /// No description provided for @signup_username_taken.
  ///
  /// In en, this message translates to:
  /// **'This username is taken'**
  String get signup_username_taken;

  /// No description provided for @signup_email_exists.
  ///
  /// In en, this message translates to:
  /// **'This email already exists'**
  String get signup_email_exists;

  /// No description provided for @signup_invalid_email_format.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get signup_invalid_email_format;

  /// No description provided for @signup_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed creating an account'**
  String get signup_failed;

  /// No description provided for @signup_password_weak.
  ///
  /// In en, this message translates to:
  /// **'Use 8 or more characters with a mix of\nuppercase and lowercase letters and\nnumbers'**
  String get signup_password_weak;

  /// No description provided for @signup_age_checkbox.
  ///
  /// In en, this message translates to:
  /// **'I am 18 years old or older'**
  String get signup_age_checkbox;

  /// No description provided for @signup_button.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup_button;

  /// No description provided for @signup_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get signup_have_account;

  /// No description provided for @signup_login_link.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get signup_login_link;

  /// No description provided for @google_signup.
  ///
  /// In en, this message translates to:
  /// **'Sign up with Google'**
  String get google_signup;

  /// No description provided for @check_18yo_checkbox.
  ///
  /// In en, this message translates to:
  /// **'Please confirm that you are 18 years old or older'**
  String get check_18yo_checkbox;

  /// No description provided for @signup_account_created_success.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully!'**
  String get signup_account_created_success;

  /// No description provided for @signup_email_verification_message.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a verification link to your email.\nPlease check your inbox and click the link to verify your email before logging in.\nIf you don\'t see it in your inbox, please check your Spam or Junk folder.'**
  String get signup_email_verification_message;

  /// No description provided for @signup_username_rules.
  ///
  /// In en, this message translates to:
  /// **'Username must contain at least one letter,\nit can only include letters, numbers, dots (.),\nunderscores (_), and no spaces allowed.'**
  String get signup_username_rules;

  /// No description provided for @signup_username_min_length.
  ///
  /// In en, this message translates to:
  /// **'Username must be at least 3 characters or more'**
  String get signup_username_min_length;

  /// No description provided for @signup_all_details_valid.
  ///
  /// In en, this message translates to:
  /// **'All details must be valid'**
  String get signup_all_details_valid;

  /// No description provided for @forgot_title.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgot_title;

  /// No description provided for @forgot_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email account to\nreset your password'**
  String get forgot_subtitle;

  /// No description provided for @forgot_email_label.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get forgot_email_label;

  /// No description provided for @forgot_reset_button.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get forgot_reset_button;

  /// No description provided for @forgot_email_empty.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get forgot_email_empty;

  /// No description provided for @forgot_send_otp_code.
  ///
  /// In en, this message translates to:
  /// **'Send OTP Code'**
  String get forgot_send_otp_code;

  /// No description provided for @forgot_failed_otp.
  ///
  /// In en, this message translates to:
  /// **'Failed to send OTP, Try again later'**
  String get forgot_failed_otp;

  /// No description provided for @forgot_network_error.
  ///
  /// In en, this message translates to:
  /// **'Network error, please check your internet connection'**
  String get forgot_network_error;

  /// No description provided for @verify_title.
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get verify_title;

  /// No description provided for @verify_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Please check your email for the\nverification code'**
  String get verify_subtitle;

  /// No description provided for @verify_button.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify_button;

  /// No description provided for @verify_resend.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get verify_resend;

  /// No description provided for @verify_reset_password_email.
  ///
  /// In en, this message translates to:
  /// **'Reset Password Email'**
  String get verify_reset_password_email;

  /// No description provided for @verify_reset_password_info.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent you an email to reset your password.\n If you don\'t see it in your inbox, check your Spam or Junk folder.'**
  String get verify_reset_password_info;

  /// No description provided for @verify_invalid_code.
  ///
  /// In en, this message translates to:
  /// **'Invalid or expired code, please try again'**
  String get verify_invalid_code;

  /// No description provided for @verify_new_otp_sent.
  ///
  /// In en, this message translates to:
  /// **'New OTP sent successfully'**
  String get verify_new_otp_sent;

  /// No description provided for @verify_failed_resend_otp.
  ///
  /// In en, this message translates to:
  /// **'Failed to resend OTP, try again later'**
  String get verify_failed_resend_otp;

  /// No description provided for @verify_wait_timer.
  ///
  /// In en, this message translates to:
  /// **'Please wait for the timer to finish to get a new OTP code'**
  String get verify_wait_timer;

  /// No description provided for @reset_password_changed_title.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get reset_password_changed_title;

  /// No description provided for @reset_password_changed_message.
  ///
  /// In en, this message translates to:
  /// **'Please log in with your new password to access the app'**
  String get reset_password_changed_message;

  /// No description provided for @reset_password_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to change password'**
  String get reset_password_failed;

  /// No description provided for @reset_password_error.
  ///
  /// In en, this message translates to:
  /// **'Error resetting password'**
  String get reset_password_error;

  /// No description provided for @reset_title.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_title;

  /// No description provided for @reset_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter and confirm your new password'**
  String get reset_subtitle;

  /// No description provided for @reset_new_password_label.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get reset_new_password_label;

  /// No description provided for @reset_confirm_password_label.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get reset_confirm_password_label;

  /// No description provided for @reset_button.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_button;

  /// No description provided for @reset_password_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords must match'**
  String get reset_password_match;

  /// No description provided for @home_what_item_question.
  ///
  /// In en, this message translates to:
  /// **'What item are you reporting?'**
  String get home_what_item_question;

  /// No description provided for @home_lost_button.
  ///
  /// In en, this message translates to:
  /// **'Lost'**
  String get home_lost_button;

  /// No description provided for @home_found_button.
  ///
  /// In en, this message translates to:
  /// **'Found'**
  String get home_found_button;

  /// No description provided for @home_stats_brand.
  ///
  /// In en, this message translates to:
  /// **'Wujed '**
  String get home_stats_brand;

  /// No description provided for @home_stats_suffix.
  ///
  /// In en, this message translates to:
  /// **'in numbers'**
  String get home_stats_suffix;

  /// No description provided for @home_stat_reports_title.
  ///
  /// In en, this message translates to:
  /// **'Reports\nSubmitted'**
  String get home_stat_reports_title;

  /// No description provided for @home_stat_items_title.
  ///
  /// In en, this message translates to:
  /// **'Items\nRecovered'**
  String get home_stat_items_title;

  /// No description provided for @home_stat_matches_title.
  ///
  /// In en, this message translates to:
  /// **'Matches\nFound'**
  String get home_stat_matches_title;

  /// No description provided for @home_stat_reports_value.
  ///
  /// In en, this message translates to:
  /// **'2100+'**
  String get home_stat_reports_value;

  /// No description provided for @home_stat_items_value.
  ///
  /// In en, this message translates to:
  /// **'1600+'**
  String get home_stat_items_value;

  /// No description provided for @home_stat_matches_value.
  ///
  /// In en, this message translates to:
  /// **'1800+'**
  String get home_stat_matches_value;

  /// No description provided for @home_card_title.
  ///
  /// In en, this message translates to:
  /// **'Coffee Brewer'**
  String get home_card_title;

  /// No description provided for @home_card_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Check back with your\nprevious report'**
  String get home_card_subtitle;

  /// No description provided for @home_card_view_arrow_aria.
  ///
  /// In en, this message translates to:
  /// **'View report details'**
  String get home_card_view_arrow_aria;

  /// No description provided for @home_note.
  ///
  /// In en, this message translates to:
  /// **'Stay safe, meet in public areas, and avoid sharing personal details.'**
  String get home_note;

  /// No description provided for @navbar_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navbar_home;

  /// No description provided for @navbar_history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get navbar_history;

  /// No description provided for @navbar_messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get navbar_messages;

  /// No description provided for @navbar_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navbar_profile;

  /// No description provided for @notifications_title.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications_title;

  /// No description provided for @notifications_expired_title.
  ///
  /// In en, this message translates to:
  /// **'Report Expired '**
  String get notifications_expired_title;

  /// No description provided for @notifications_expired_body.
  ///
  /// In en, this message translates to:
  /// **'your report of Item5 has expired\ndue to unconfirmed receipt.'**
  String get notifications_expired_body;

  /// No description provided for @notifications_new_match_title.
  ///
  /// In en, this message translates to:
  /// **'New Match Found'**
  String get notifications_new_match_title;

  /// No description provided for @notifications_new_match_body.
  ///
  /// In en, this message translates to:
  /// **'A new match has been found for\nyour report of Coffee Brewer.'**
  String get notifications_new_match_body;

  /// No description provided for @notifications_expiring_soon_title.
  ///
  /// In en, this message translates to:
  /// **'Report Expiring Soon '**
  String get notifications_expiring_soon_title;

  /// No description provided for @notifications_expiring_soon_body.
  ///
  /// In en, this message translates to:
  /// **'Your report of Coffee Brewer will\nexpire in 5 days unless you renew it\nor accept a match.'**
  String get notifications_expiring_soon_body;

  /// No description provided for @notifications_time_2d.
  ///
  /// In en, this message translates to:
  /// **'2 days ago'**
  String get notifications_time_2d;

  /// No description provided for @notifications_time_6d.
  ///
  /// In en, this message translates to:
  /// **'6 days ago'**
  String get notifications_time_6d;

  /// No description provided for @notifications_time_9d.
  ///
  /// In en, this message translates to:
  /// **'9 days ago'**
  String get notifications_time_9d;

  /// No description provided for @report_found_title.
  ///
  /// In en, this message translates to:
  /// **'Report A Found Item'**
  String get report_found_title;

  /// No description provided for @report_lost_title.
  ///
  /// In en, this message translates to:
  /// **'Report A Lost Item'**
  String get report_lost_title;

  /// No description provided for @report_required_details.
  ///
  /// In en, this message translates to:
  /// **'Please fill all required details'**
  String get report_required_details;

  /// No description provided for @report_title_label.
  ///
  /// In en, this message translates to:
  /// **'Title '**
  String get report_title_label;

  /// No description provided for @report_title_hint.
  ///
  /// In en, this message translates to:
  /// **'Example: Brown wallet'**
  String get report_title_hint;

  /// No description provided for @report_photo_label.
  ///
  /// In en, this message translates to:
  /// **'Photo '**
  String get report_photo_label;

  /// No description provided for @report_location_label.
  ///
  /// In en, this message translates to:
  /// **'Location '**
  String get report_location_label;

  /// No description provided for @report_location_button_hint.
  ///
  /// In en, this message translates to:
  /// **'Click here to add a Location'**
  String get report_location_button_hint;

  /// No description provided for @report_description_label.
  ///
  /// In en, this message translates to:
  /// **'Description '**
  String get report_description_label;

  /// No description provided for @report_description_hint.
  ///
  /// In en, this message translates to:
  /// **'Describe your item (Type, Color, Brand, etc)'**
  String get report_description_hint;

  /// No description provided for @report_counter_left.
  ///
  /// In en, this message translates to:
  /// **'{remaining} characters left'**
  String report_counter_left(int remaining);

  /// No description provided for @report_submit_button.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get report_submit_button;

  /// No description provided for @report_upload_photos_hint.
  ///
  /// In en, this message translates to:
  /// **'Click here to add up to 2 Photos'**
  String get report_upload_photos_hint;

  /// No description provided for @sheet_choose_location_title.
  ///
  /// In en, this message translates to:
  /// **'Choose a Location'**
  String get sheet_choose_location_title;

  /// No description provided for @sheet_current_location_title.
  ///
  /// In en, this message translates to:
  /// **'Your current location'**
  String get sheet_current_location_title;

  /// No description provided for @sheet_current_location_sub.
  ///
  /// In en, this message translates to:
  /// **'King Saud University, Riyadh 12372'**
  String get sheet_current_location_sub;

  /// No description provided for @sheet_choose_manually.
  ///
  /// In en, this message translates to:
  /// **'Choose Manually'**
  String get sheet_choose_manually;

  /// No description provided for @sheet_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get sheet_confirm;

  /// No description provided for @sheet_send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get sheet_send;

  /// No description provided for @history_title.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history_title;

  /// No description provided for @history_tab_lost.
  ///
  /// In en, this message translates to:
  /// **'Lost'**
  String get history_tab_lost;

  /// No description provided for @history_tab_found.
  ///
  /// In en, this message translates to:
  /// **'Found'**
  String get history_tab_found;

  /// No description provided for @item_title_coffee_brewer.
  ///
  /// In en, this message translates to:
  /// **'Coffee Brewer'**
  String get item_title_coffee_brewer;

  /// No description provided for @item_title_coffee_mug.
  ///
  /// In en, this message translates to:
  /// **'Coffee Mug'**
  String get item_title_coffee_mug;

  /// No description provided for @details_location_label.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get details_location_label;

  /// No description provided for @details_description_label.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get details_description_label;

  /// No description provided for @lost_found_matches_title.
  ///
  /// In en, this message translates to:
  /// **'Found Matches'**
  String get lost_found_matches_title;

  /// No description provided for @match_confidence.
  ///
  /// In en, this message translates to:
  /// **'{percent}% Your Item'**
  String match_confidence(int percent);

  /// No description provided for @dialog_are_you_sure_item.
  ///
  /// In en, this message translates to:
  /// **'Are you sure this is your item?'**
  String get dialog_are_you_sure_item;

  /// No description provided for @dialog_accept_match_note.
  ///
  /// In en, this message translates to:
  /// **'Accepting this match will hide the others. If it\'s not your item, just tap \'Revoke\' to bring them back.'**
  String get dialog_accept_match_note;

  /// No description provided for @dialog_are_you_sure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get dialog_are_you_sure;

  /// No description provided for @dialog_remove_permanently_note.
  ///
  /// In en, this message translates to:
  /// **'This match will be removed permanently. Continue only if you\'re sure it\'s not your item.'**
  String get dialog_remove_permanently_note;

  /// No description provided for @dialog_confirm_received_note.
  ///
  /// In en, this message translates to:
  /// **'Continue only if you’re certain that you’ve received your item.'**
  String get dialog_confirm_received_note;

  /// No description provided for @report_cancel_dialog_info.
  ///
  /// In en, this message translates to:
  /// **'Deleting this report means it will be removed and no longer processed.'**
  String get report_cancel_dialog_info;

  /// No description provided for @btn_accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get btn_accept;

  /// No description provided for @btn_reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get btn_reject;

  /// No description provided for @btn_revoke.
  ///
  /// In en, this message translates to:
  /// **'Revoke'**
  String get btn_revoke;

  /// No description provided for @btn_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get btn_confirm;

  /// No description provided for @btn_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get btn_cancel;

  /// No description provided for @btn_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get btn_delete;

  /// No description provided for @btn_renew.
  ///
  /// In en, this message translates to:
  /// **'Renew'**
  String get btn_renew;

  /// No description provided for @btn_confirm_receipt.
  ///
  /// In en, this message translates to:
  /// **'Confirm Receipt'**
  String get btn_confirm_receipt;

  /// No description provided for @btn_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get btn_continue;

  /// No description provided for @toast_congrats.
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get toast_congrats;

  /// No description provided for @toast_got_item_back.
  ///
  /// In en, this message translates to:
  /// **'You got your item back!\nEnjoy having it safe and sound again'**
  String get toast_got_item_back;

  /// No description provided for @submit_success_title.
  ///
  /// In en, this message translates to:
  /// **'All done! your report has been\nsubmitted successfully'**
  String get submit_success_title;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Wujed'**
  String get appTitle;

  /// No description provided for @messages_title.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages_title;

  /// No description provided for @messages_you_prefix.
  ///
  /// In en, this message translates to:
  /// **'You:'**
  String get messages_you_prefix;

  /// No description provided for @messages_typing.
  ///
  /// In en, this message translates to:
  /// **'Typing...'**
  String get messages_typing;

  /// No description provided for @messages_items_matched.
  ///
  /// In en, this message translates to:
  /// **'Your Items Matched!'**
  String get messages_items_matched;

  /// No description provided for @action_block.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get action_block;

  /// No description provided for @chat_hello_found_item.
  ///
  /// In en, this message translates to:
  /// **'Hello, I think I found your item'**
  String get chat_hello_found_item;

  /// No description provided for @chat_great_do.
  ///
  /// In en, this message translates to:
  /// **'Great! Let\'s do'**
  String get chat_great_do;

  /// No description provided for @chat_lets_decide.
  ///
  /// In en, this message translates to:
  /// **'Let\'s decide on a place and time to meet!'**
  String get chat_lets_decide;

  /// No description provided for @chat_yes_match.
  ///
  /// In en, this message translates to:
  /// **'Yes in fact it does match'**
  String get chat_yes_match;

  /// No description provided for @chat_id_request.
  ///
  /// In en, this message translates to:
  /// **'That sounds like mine. Inside there should be a student ID with the name Ghaida Mo. Can you check if it matches?'**
  String get chat_id_request;

  /// No description provided for @chat_hello.
  ///
  /// In en, this message translates to:
  /// **'Hello!'**
  String get chat_hello;

  /// No description provided for @chat_date.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get chat_date;

  /// No description provided for @chat_hint.
  ///
  /// In en, this message translates to:
  /// **'Type Your Message...'**
  String get chat_hint;

  /// No description provided for @profile_title.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile_title;

  /// No description provided for @menu_switch_language.
  ///
  /// In en, this message translates to:
  /// **'Switch Language'**
  String get menu_switch_language;

  /// No description provided for @language_en.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language_en;

  /// No description provided for @language_ar.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get language_ar;

  /// No description provided for @action_log_out.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get action_log_out;

  /// No description provided for @blocked_users.
  ///
  /// In en, this message translates to:
  /// **'Blocked Users'**
  String get blocked_users;

  /// No description provided for @unblock_user.
  ///
  /// In en, this message translates to:
  /// **'Unblock'**
  String get unblock_user;

  /// No description provided for @unblock_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Unblock User'**
  String get unblock_dialog_title;

  /// No description provided for @unblock_user_confirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to unblock {name}?'**
  String unblock_user_confirm(String name);

  /// No description provided for @label_first_name.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get label_first_name;

  /// No description provided for @label_last_name.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get label_last_name;

  /// No description provided for @label_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get label_phone_number;

  /// No description provided for @placeholder_not_provided.
  ///
  /// In en, this message translates to:
  /// **'Not provided'**
  String get placeholder_not_provided;

  /// No description provided for @edit_profile_title.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get edit_profile_title;

  /// No description provided for @edit_profile_change_picture.
  ///
  /// In en, this message translates to:
  /// **'Change Profile Picture'**
  String get edit_profile_change_picture;

  /// No description provided for @action_done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get action_done;

  /// No description provided for @onboarding_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboarding_skip;

  /// No description provided for @onboarding_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboarding_next;

  /// No description provided for @onboarding_done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get onboarding_done;

  /// No description provided for @btn_send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get btn_send;

  /// No description provided for @btn_ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get btn_ok;

  /// No description provided for @common_error_generic.
  ///
  /// In en, this message translates to:
  /// **'Oops, something went wrong'**
  String get common_error_generic;

  /// No description provided for @common_empty.
  ///
  /// In en, this message translates to:
  /// **'No information yet'**
  String get common_empty;

  /// No description provided for @common_untitled.
  ///
  /// In en, this message translates to:
  /// **'Untitled'**
  String get common_untitled;

  /// No description provided for @label_value_missing.
  ///
  /// In en, this message translates to:
  /// **'Not provided'**
  String get label_value_missing;

  /// No description provided for @phone_placeholder.
  ///
  /// In en, this message translates to:
  /// **'5XXXXXXXX'**
  String get phone_placeholder;

  /// No description provided for @no_new_data_entered.
  ///
  /// In en, this message translates to:
  /// **'No new data entered'**
  String get no_new_data_entered;

  /// No description provided for @profile_update_success.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully!'**
  String get profile_update_success;

  /// No description provided for @profile_update_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed updating profile'**
  String get profile_update_failed;

  /// No description provided for @first_name_too_short.
  ///
  /// In en, this message translates to:
  /// **'First name must be at least 2 characters'**
  String get first_name_too_short;

  /// No description provided for @last_name_too_short.
  ///
  /// In en, this message translates to:
  /// **'Last name must be at least 2 characters'**
  String get last_name_too_short;

  /// No description provided for @phone_invalid_length.
  ///
  /// In en, this message translates to:
  /// **'Phone number must be exactly 9 numbers'**
  String get phone_invalid_length;

  /// No description provided for @history_no_found_reports.
  ///
  /// In en, this message translates to:
  /// **'No found reports yet'**
  String get history_no_found_reports;

  /// No description provided for @history_no_lost_reports.
  ///
  /// In en, this message translates to:
  /// **'No lost reports yet'**
  String get history_no_lost_reports;

  /// No description provided for @status_ongoing.
  ///
  /// In en, this message translates to:
  /// **'Ongoing'**
  String get status_ongoing;

  /// No description provided for @status_done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get status_done;

  /// No description provided for @status_rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get status_rejected;

  /// No description provided for @status_match_found.
  ///
  /// In en, this message translates to:
  /// **'Match found'**
  String get status_match_found;

  /// No description provided for @status_expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get status_expired;

  /// No description provided for @pick_location_enable_service_title.
  ///
  /// In en, this message translates to:
  /// **'Location Service'**
  String get pick_location_enable_service_title;

  /// No description provided for @pick_location_enable_service_body.
  ///
  /// In en, this message translates to:
  /// **'Please enable location services.'**
  String get pick_location_enable_service_body;

  /// No description provided for @pick_location_permission_title.
  ///
  /// In en, this message translates to:
  /// **'Location Permission'**
  String get pick_location_permission_title;

  /// No description provided for @pick_location_permission_body.
  ///
  /// In en, this message translates to:
  /// **'Please enable location permission.'**
  String get pick_location_permission_body;

  /// No description provided for @pick_location_permission_settings_body.
  ///
  /// In en, this message translates to:
  /// **'Please enable location permission from settings.'**
  String get pick_location_permission_settings_body;

  /// No description provided for @pick_location_error_title.
  ///
  /// In en, this message translates to:
  /// **'Location Error'**
  String get pick_location_error_title;

  /// No description provided for @pick_location_error_body.
  ///
  /// In en, this message translates to:
  /// **'Could not get current location. Please try again or choose your location manually.'**
  String get pick_location_error_body;

  /// No description provided for @pick_location_tap_hint.
  ///
  /// In en, this message translates to:
  /// **'Tap the map to choose a spot'**
  String get pick_location_tap_hint;

  /// No description provided for @title_indicator.
  ///
  /// In en, this message translates to:
  /// **'characters left'**
  String get title_indicator;

  /// No description provided for @snackbar_fill_fields.
  ///
  /// In en, this message translates to:
  /// **'Please fill title and description'**
  String get snackbar_fill_fields;

  /// No description provided for @snackbar_pick_location.
  ///
  /// In en, this message translates to:
  /// **'Please pick a location'**
  String get snackbar_pick_location;

  /// No description provided for @snackbar_add_photos.
  ///
  /// In en, this message translates to:
  /// **'Please add at least 1 photo'**
  String get snackbar_add_photos;

  /// No description provided for @snackbar_submit_failed.
  ///
  /// In en, this message translates to:
  /// **'Submit failed: {error}'**
  String snackbar_submit_failed(Object error);

  /// No description provided for @snackbar_location_set.
  ///
  /// In en, this message translates to:
  /// **'Location set successfully'**
  String get snackbar_location_set;

  /// No description provided for @snackbar_location_not_selected.
  ///
  /// In en, this message translates to:
  /// **'Location not selected'**
  String get snackbar_location_not_selected;

  /// No description provided for @report_submitting.
  ///
  /// In en, this message translates to:
  /// **'Submitting…'**
  String get report_submitting;

  /// No description provided for @outside_riyadh.
  ///
  /// In en, this message translates to:
  /// **'Outside Riyadh'**
  String get outside_riyadh;

  /// No description provided for @outside_dialog.
  ///
  /// In en, this message translates to:
  /// **'Your location is outside Riyadh boundaries.'**
  String get outside_dialog;

  /// No description provided for @error_allow_photo_access.
  ///
  /// In en, this message translates to:
  /// **'Please allow photo access to upload images'**
  String get error_allow_photo_access;

  /// No description provided for @error_max_photos.
  ///
  /// In en, this message translates to:
  /// **'You can only upload up to 2 photos'**
  String get error_max_photos;

  /// No description provided for @error_save_gallery.
  ///
  /// In en, this message translates to:
  /// **'Failed to save photo to gallery'**
  String get error_save_gallery;

  /// No description provided for @error_duplicate_photo.
  ///
  /// In en, this message translates to:
  /// **'You uploaded this photo already'**
  String get error_duplicate_photo;

  /// No description provided for @error_enable_photo_access.
  ///
  /// In en, this message translates to:
  /// **'Please enable photo access in Settings'**
  String get error_enable_photo_access;

  /// No description provided for @error_create_report.
  ///
  /// In en, this message translates to:
  /// **'Failed creating report'**
  String get error_create_report;

  /// No description provided for @error_submit_report.
  ///
  /// In en, this message translates to:
  /// **'Failed submitting report'**
  String get error_submit_report;

  /// No description provided for @report_sumbitted_successfully.
  ///
  /// In en, this message translates to:
  /// **'All done! your report has been\nsubmitted successfully'**
  String get report_sumbitted_successfully;

  /// No description provided for @couldnt_process.
  ///
  /// In en, this message translates to:
  /// **'Your report could not be processed. Please try again.'**
  String get couldnt_process;

  /// No description provided for @describe_clearly.
  ///
  /// In en, this message translates to:
  /// **'Please describe the item more clearly.'**
  String get describe_clearly;

  /// No description provided for @image_unclear.
  ///
  /// In en, this message translates to:
  /// **'The image looks unclear. Try uploading a clearer photo.'**
  String get image_unclear;

  /// No description provided for @error_profile_picture_update_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update profile picture. Please try again.'**
  String get error_profile_picture_update_failed;

  /// No description provided for @success_profile_picture_updated.
  ///
  /// In en, this message translates to:
  /// **'Profile picture updated successfully!'**
  String get success_profile_picture_updated;

  /// No description provided for @validation_phone_9_digits.
  ///
  /// In en, this message translates to:
  /// **'Phone number must be exactly 9 numbers'**
  String get validation_phone_9_digits;

  /// No description provided for @reject_notif.
  ///
  /// In en, this message translates to:
  /// **'Your last report was rejected. Check the History page to see the reason.'**
  String get reject_notif;

  /// No description provided for @report_rejected.
  ///
  /// In en, this message translates to:
  /// **'Report Rejected'**
  String get report_rejected;

  /// No description provided for @now.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get now;

  /// No description provided for @important.
  ///
  /// In en, this message translates to:
  /// **'Important: '**
  String get important;

  /// No description provided for @important_box.
  ///
  /// In en, this message translates to:
  /// **'This report is analyzed by AI. Describe the item clearly and avoid personal information or emotional text.'**
  String get important_box;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note: '**
  String get note;

  /// No description provided for @note_box.
  ///
  /// In en, this message translates to:
  /// **'Please describe only one item per report.'**
  String get note_box;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
