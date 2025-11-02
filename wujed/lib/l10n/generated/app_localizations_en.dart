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
  String get login_error_too_many_attepmts =>
      'Too many log in attempts\nPlease try again in 3 minutes';

  @override
  String get login_error_failed => 'Login failed, Please try again';

  @override
  String login_locked(int remaining) {
    return 'Please wait $remaining seconds before trying again';
  }

  @override
  String get login_email_not_verified => 'Email is not verified';

  @override
  String get login_email_verification_message =>
      'We\'ve sent a verification link to your email.\nPlease check your inbox and click the link to verify your email before logging in.\nIf you don\'t see it in your inbox, check your Spam or Junk folder.\n\nIf you didn\'t receive it or it expired, press Resend. If you got it, press Continue.';

  @override
  String get login_btn_resend => 'Resend';

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
  String get signup_invalid_email_format => 'Invalid email format';

  @override
  String get signup_failed => 'Failed creating an account';

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
  String get check_18yo_checkbox =>
      'Please confirm that you are 18 years old or older';

  @override
  String get signup_account_created_success => 'Account created successfully!';

  @override
  String get signup_email_verification_message =>
      'We\'ve sent a verification link to your email.\nPlease check your inbox and click the link to verify your email before logging in.\nIf you don\'t see it in your inbox, please check your Spam or Junk folder.';

  @override
  String get signup_username_rules =>
      'Username must contain at least one letter,\nit can only include letters, numbers, dots (.),\nunderscores (_), and no spaces allowed.';

  @override
  String get signup_username_min_length =>
      'Username must be at least 3 characters or more';

  @override
  String get signup_all_details_valid => 'All details must be valid';

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
  String get forgot_email_empty => 'Please enter your email';

  @override
  String get forgot_send_otp_code => 'Send OTP Code';

  @override
  String get forgot_failed_otp => 'Failed to send OTP, Try again later';

  @override
  String get forgot_network_error =>
      'Network error, please check your internet connection';

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
  String get verify_reset_password_email => 'Reset Password Email';

  @override
  String get verify_reset_password_info =>
      'We\'ve sent you an email to reset your password.\n If you don\'t see it in your inbox, check your Spam or Junk folder.';

  @override
  String get verify_invalid_code => 'Invalid or expired code, please try again';

  @override
  String get verify_new_otp_sent => 'New OTP sent successfully';

  @override
  String get verify_failed_resend_otp =>
      'Failed to resend OTP, try again later';

  @override
  String get verify_wait_timer =>
      'Please wait for the timer to finish to get a new OTP code';

  @override
  String get reset_password_changed_title => 'Password changed successfully';

  @override
  String get reset_password_changed_message =>
      'Please log in with your new password to access the app';

  @override
  String get reset_password_failed => 'Failed to change password';

  @override
  String get reset_password_error => 'Error resetting password';

  @override
  String get reset_title => 'Reset Password';

  @override
  String get reset_subtitle => 'Enter and confirm your new password';

  @override
  String get reset_new_password_label => 'New Password';

  @override
  String get reset_confirm_password_label => 'Confirm Password';

  @override
  String get reset_button => 'Reset Password';

  @override
  String get reset_password_match => 'Passwords must match';

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
  String get home_note =>
      'Stay safe, meet in public areas, and avoid sharing personal details.';

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
  String get dialog_confirm_received_note =>
      'Continue only if you’re certain that you’ve received your item.';

  @override
  String get report_cancel_dialog_info =>
      'Deleting this report means it will be removed and no longer processed.';

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
  String get btn_delete => 'Delete';

  @override
  String get btn_renew => 'Renew';

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
  String get blocked_users => 'Blocked Users';

  @override
  String get unblock_user => 'Unblock';

  @override
  String get unblock_dialog_title => 'Unblock User';

  @override
  String unblock_user_confirm(String name) {
    return 'Are you sure you want to unblock $name?';
  }

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

  @override
  String get btn_ok => 'Ok';

  @override
  String get common_error_generic => 'Oops, something went wrong';

  @override
  String get common_empty => 'No information yet';

  @override
  String get common_untitled => 'Untitled';

  @override
  String get label_value_missing => 'Not provided';

  @override
  String get phone_placeholder => '5XXXXXXXX';

  @override
  String get no_new_data_entered => 'No new data entered';

  @override
  String get profile_update_success => 'Profile updated successfully!';

  @override
  String get profile_update_failed => 'Failed updating profile';

  @override
  String get first_name_too_short => 'First name must be at least 2 characters';

  @override
  String get last_name_too_short => 'Last name must be at least 2 characters';

  @override
  String get phone_invalid_length => 'Phone number must be exactly 9 numbers';

  @override
  String get history_no_found_reports => 'No found reports yet';

  @override
  String get history_no_lost_reports => 'No lost reports yet';

  @override
  String get status_ongoing => 'Ongoing';

  @override
  String get status_done => 'Done';

  @override
  String get status_rejected => 'Rejected';

  @override
  String get status_match_found => 'Match found';

  @override
  String get status_expired => 'Expired';

  @override
  String get pick_location_enable_service_title => 'Location Service';

  @override
  String get pick_location_enable_service_body =>
      'Please enable location services.';

  @override
  String get pick_location_permission_title => 'Location Permission';

  @override
  String get pick_location_permission_body =>
      'Please enable location permission.';

  @override
  String get pick_location_permission_settings_body =>
      'Please enable location permission from settings.';

  @override
  String get pick_location_error_title => 'Location Error';

  @override
  String get pick_location_error_body =>
      'Could not get current location. Please try again or choose your location manually.';

  @override
  String get pick_location_tap_hint => 'Tap the map to choose a spot';

  @override
  String get title_indicator => 'characters left';

  @override
  String get snackbar_fill_fields => 'Please fill title and description';

  @override
  String get snackbar_pick_location => 'Please pick a location';

  @override
  String get snackbar_add_photos => 'Please add at least 1 photo';

  @override
  String snackbar_submit_failed(Object error) {
    return 'Submit failed: $error';
  }

  @override
  String get snackbar_location_set => 'Location set successfully';

  @override
  String get snackbar_location_not_selected => 'Location not selected';

  @override
  String get report_submitting => 'Submitting…';

  @override
  String get outside_riyadh => 'Outside Riyadh';

  @override
  String get outside_dialog => 'Your location is outside Riyadh boundaries.';
}
