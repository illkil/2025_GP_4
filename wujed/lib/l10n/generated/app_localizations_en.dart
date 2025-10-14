// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get intro1_title_part1 => 'Welcome to ';

  @override
  String get intro1_title_part2 => 'Wujed';

  @override
  String get intro1_description =>
      'Every lost item has a way back home. With\nWujed, you can find what’s missing or help\nreturn what’s found.';

  @override
  String get intro2_title_part1 => 'We’ll help you ';

  @override
  String get intro2_title_part2 => 'find it';

  @override
  String get intro2_description =>
      'Simply report what’s lost or found, and Wujed’s\nAI works to bring people and their belongings\nback together.';

  @override
  String get intro3_title_part1 => 'Your part ';

  @override
  String get intro3_title_part2 => 'matters';

  @override
  String get intro3_description =>
      'Your reports help someone find what they’ve\nlost and together, we make a difference.';

  @override
  String get login_title => 'Welcome Back!';

  @override
  String get login_subtitle => 'Please Log in to continue';

  @override
  String get login_email_label => 'Email';

  @override
  String get login_password_label => 'Password';

  @override
  String get login_forgot_password => 'Forgot Password?';

  @override
  String get login_button => 'Log In';

  @override
  String get login_no_account => 'Don\'t have an account?';

  @override
  String get login_signup_link => 'Sign Up';

  @override
  String get common_or => 'OR';

  @override
  String get google_continue => 'Continue with Google';

  @override
  String get login_error_fill_all => 'Please fill all the details';

  @override
  String get login_error_invalid => 'Invalid email or password';

  @override
  String get signup_title => 'Join Us!';

  @override
  String get signup_subtitle => 'Fill all the details to create your account';

  @override
  String get signup_username_label => 'Username';

  @override
  String get signup_email_label => 'Email';

  @override
  String get signup_password_label => 'Password';

  @override
  String get signup_username_taken => 'This username is taken';

  @override
  String get signup_email_exists => 'This email already exists';

  @override
  String get signup_password_weak =>
      'Use 8 or more characters with a mix of\nuppercase and lowercase letters and\nnumbers';

  @override
  String get signup_age_checkbox => 'I am 18 years old or older';

  @override
  String get signup_button => 'Sign Up';

  @override
  String get signup_have_account => 'Already have an account?';

  @override
  String get signup_login_link => 'Log In';

  @override
  String get google_signup => 'Sign up with Google';

  @override
  String get forgot_title => 'Forgot Password';

  @override
  String get forgot_subtitle =>
      'Enter your email account to\nreset your password';

  @override
  String get forgot_email_label => 'Email';

  @override
  String get forgot_reset_button => 'Reset Password';

  @override
  String get verify_title => 'OTP Verification';

  @override
  String get verify_subtitle =>
      'Please check your email for the\nverification code';

  @override
  String get verify_button => 'Verify';

  @override
  String get verify_resend => 'Resend code';

  @override
  String get home_what_item_question => 'What item are you reporting?';

  @override
  String get home_lost_button => 'Lost';

  @override
  String get home_found_button => 'Found';

  @override
  String get home_stats_brand => 'Wujed ';

  @override
  String get home_stats_suffix => 'in numbers';

  @override
  String get home_stat_reports_title => 'Reports\nSubmitted';

  @override
  String get home_stat_items_title => 'Items\nRecovered';

  @override
  String get home_stat_matches_title => 'Matches\nFound';

  @override
  String get home_stat_reports_value => '2100+';

  @override
  String get home_stat_items_value => '1600+';

  @override
  String get home_stat_matches_value => '1800+';

  @override
  String get home_card_title => 'Coffee Brewer';

  @override
  String get home_card_subtitle => 'Check back with your\nprevious report';

  @override
  String get home_card_view_arrow_aria => 'View report details';

  @override
  String get navbar_home => 'Home';

  @override
  String get navbar_history => 'History';

  @override
  String get navbar_messages => 'Messages';

  @override
  String get navbar_profile => 'Profile';

  @override
  String get notifications_title => 'Notifications';

  @override
  String get notifications_expired_title => 'Report Expired ';

  @override
  String get notifications_expired_body =>
      'your report of Item5 has expired\ndue to unconfirmed receipt.';

  @override
  String get notifications_new_match_title => 'New Match Found';

  @override
  String get notifications_new_match_body =>
      'A new match has been found for\nyour report of Coffee Brewer.';

  @override
  String get notifications_expiring_soon_title => 'Report Expiring Soon ';

  @override
  String get notifications_expiring_soon_body =>
      'Your report of Coffee Brewer will\nexpire in 5 days unless you renew it\nor accept a match.';

  @override
  String get notifications_time_2d => '2 days ago';

  @override
  String get notifications_time_6d => '6 days ago';

  @override
  String get notifications_time_9d => '9 days ago';

  @override
  String get report_found_title => 'Report A Found Item';

  @override
  String get report_lost_title => 'Report A Lost Item';

  @override
  String get report_required_details => 'Please fill all required details';

  @override
  String get report_title_label => 'Title ';

  @override
  String get report_title_hint => 'Example: Brown wallet';

  @override
  String get report_photo_label => 'Photo ';

  @override
  String get report_location_label => 'Location ';

  @override
  String get report_location_button_hint => 'Click here to add a Location';

  @override
  String get report_description_label => 'Description ';

  @override
  String get report_description_hint =>
      'Describe your item (Type, Color, Brand, etc)';

  @override
  String report_counter_left(int remaining) {
    return '$remaining characters left';
  }

  @override
  String get report_submit_button => 'Submit';

  @override
  String get report_upload_photos_hint => 'Click here to add up to 2 Photos';

  @override
  String get sheet_choose_location_title => 'Choose a Location';

  @override
  String get sheet_current_location_title => 'Your current location';

  @override
  String get sheet_current_location_sub => 'King Saud University, Riyadh 12372';

  @override
  String get sheet_choose_manually => 'Choose Manually';

  @override
  String get sheet_confirm => 'Confirm';

  @override
  String get sheet_send => 'Send';

  @override
  String get history_title => 'History';

  @override
  String get history_tab_lost => 'Lost';

  @override
  String get history_tab_found => 'Found';

  @override
  String get status_ongoing => 'Ongoing';

  @override
  String get status_done => 'Done';

  @override
  String get status_rejected => 'Rejected';

  @override
  String get status_match_found => 'Match Found';

  @override
  String get status_expired => 'Expired';

  @override
  String get item_title_coffee_brewer => 'Coffee Brewer';

  @override
  String get item_title_coffee_mug => 'Coffee Mug';

  @override
  String get details_location_label => 'Location';

  @override
  String get details_description_label => 'Description';

  @override
  String get lost_found_matches_title => 'Found Matches';

  @override
  String match_confidence(int percent) {
    return '$percent% Your Item';
  }

  @override
  String get dialog_are_you_sure_item => 'Are you sure this is your item?';

  @override
  String get dialog_accept_match_note =>
      'Accepting this match will hide the others. If it\'s not your item, just tap \'Revoke\' to bring them back.';

  @override
  String get dialog_are_you_sure => 'Are you sure?';

  @override
  String get dialog_remove_permanently_note =>
      'This match will be removed permanently. Continue only if you\'re sure it\'s not your item.';

  @override
  String get btn_accept => 'Accept';

  @override
  String get btn_reject => 'Reject';

  @override
  String get btn_revoke => 'Revoke';

  @override
  String get btn_confirm => 'Confirm';

  @override
  String get btn_cancel => 'Cancel';

  @override
  String get btn_confirm_receipt => 'Confirm Receipt';

  @override
  String get btn_continue => 'Continue';

  @override
  String get toast_congrats => 'Congratulations!';

  @override
  String get toast_got_item_back =>
      'You got your item back!\nEnjoy having it safe and sound again';

  @override
  String get submit_success_title =>
      'All done! your report has been\nsubmitted successfully';

  @override
  String get appTitle => 'Wujed';

  @override
  String get messages_title => 'Messages';

  @override
  String get messages_you_prefix => 'You:';

  @override
  String get messages_typing => 'Typing...';

  @override
  String get messages_items_matched => 'Your Items Matched!';

  @override
  String get action_block => 'Block';

  @override
  String get chat_hello_found_item => 'Hello, I think I found your item';

  @override
  String get chat_great_do => 'Great! Let\'s do';

  @override
  String get chat_lets_decide => 'Let\'s decide on a place and time to meet!';

  @override
  String get chat_yes_match => 'Yes in fact it does match';

  @override
  String get chat_id_request =>
      'That sounds like mine. Inside there should be a student ID with the name Ghaida Mo. Can you check if it matches?';

  @override
  String get chat_hello => 'Hello!';

  @override
  String get chat_date => 'Today';

  @override
  String get chat_hint => 'Type Your Message...';

  @override
  String get profile_title => 'Profile';

  @override
  String get menu_switch_language => 'Switch Language';

  @override
  String get language_en => 'English';

  @override
  String get language_ar => 'العربية';

  @override
  String get action_log_out => 'Log Out';

  @override
  String get label_first_name => 'First Name';

  @override
  String get label_last_name => 'Last Name';

  @override
  String get label_phone_number => 'Phone Number';

  @override
  String get placeholder_not_provided => 'Not provided';

  @override
  String get edit_profile_title => 'Edit Profile';

  @override
  String get edit_profile_change_picture => 'Change Profile Picture';

  @override
  String get action_done => 'Done';

  @override
  String get onboarding_skip => 'Skip';

  @override
  String get onboarding_next => 'Next';

  @override
  String get onboarding_done => 'Done';

  @override
  String get btn_send => 'Send';
}
