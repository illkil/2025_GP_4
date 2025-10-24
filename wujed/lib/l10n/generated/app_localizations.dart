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
  /// **'Delete'**
  String get btn_cancel;

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

  /// No description provided for @label_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get label_email;

  /// No description provided for @label_username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get label_username;

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
  /// **'—'**
  String get label_value_missing;

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

  /// No description provided for @status_submitted.
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get status_submitted;

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
