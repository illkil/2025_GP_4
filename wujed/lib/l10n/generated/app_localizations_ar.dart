// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get intro1_title_part1 => 'مرحبًا بك في ';

  @override
  String get intro1_title_part2 => 'وُجِد';

  @override
  String get intro1_description =>
      'كل غرض مفقود له طريق للعودة. مع وجد، يمكنك العثور على ما فقدته\nأو المساعدة في إعادة ما تم العثور عليه.';

  @override
  String get intro2_title_part1 => 'سوف نساعدك ';

  @override
  String get intro2_title_part2 => 'في العثور عليه';

  @override
  String get intro2_description =>
      'ببساطة أبلغ عما فُقد أو وُجد، ويعمل ذكاء وجد الاصطناعي\nعلى جمع الناس بمقتنياتهم من جديد.';

  @override
  String get intro3_title_part1 => 'مساهمتك ';

  @override
  String get intro3_title_part2 => 'مهمة';

  @override
  String get intro3_description =>
      'تقاريرك تساعد الآخرين في إيجاد ما فقدوه\nومعًا نصنع الفرق.';

  @override
  String get login_title => 'أهلاً بعودتك!';

  @override
  String get login_subtitle => 'يرجى تسجيل الدخول للمتابعة';

  @override
  String get login_email_label => 'البريد الإلكتروني';

  @override
  String get login_password_label => 'كلمة المرور';

  @override
  String get login_forgot_password => 'نسيت كلمة المرور؟';

  @override
  String get login_button => 'تسجيل الدخول';

  @override
  String get login_no_account => 'ليس لديك حساب؟';

  @override
  String get login_signup_link => 'إنشاء حساب';

  @override
  String get common_or => 'أو';

  @override
  String get google_continue => 'المتابعة باستخدام Google';

  @override
  String get login_error_fill_all => 'يرجى تعبئة جميع البيانات';

  @override
  String get login_error_invalid =>
      'البريد الإلكتروني أو كلمة المرور غير صحيحة';

  @override
  String get login_error_too_many_attepmts =>
      'عدد كبير من محاولات تسجيل الدخول\nيرجى المحاولة مرة أخرى خلال 3 دقائق';

  @override
  String get login_error_failed => 'فشل تسجيل الدخول، يرجى المحاولة مرة أخرى';

  @override
  String login_locked(int remaining) {
    return 'الرجاء الإنتظار $remaining ثانية قبل المحاولة مرة أخرى';
  }

  @override
  String get login_email_not_verified => 'البريد الإلكتروني غير مؤكد';

  @override
  String get login_email_verification_message =>
      'لقد أرسلنا رابط التحقق إلى بريدك الإلكتروني.\nيرجى التحقق من صندوق الوارد والضغط على الرابط لتأكيد بريدك الإلكتروني قبل تسجيل الدخول.\nإذا لم تجد الرسالة في صندوق الوارد، تحقق من مجلد الرسائل غير المرغوب فيها أو المهملات.\n\nإذا لم تصلك الرسالة أو انتهت صلاحيتها، اضغط إعادة الإرسال. إذا وصلتك، اضغط متابعة.';

  @override
  String get login_btn_resend => 'إعادة الإرسال';

  @override
  String get signup_title => 'انضم إلينا!';

  @override
  String get signup_subtitle => 'املأ جميع البيانات لإنشاء حسابك';

  @override
  String get signup_username_label => 'اسم المستخدم';

  @override
  String get signup_email_label => 'البريد الإلكتروني';

  @override
  String get signup_password_label => 'كلمة المرور';

  @override
  String get signup_username_taken => 'اسم المستخدم مستخدم بالفعل';

  @override
  String get signup_email_exists => 'البريد الإلكتروني مسجّل بالفعل';

  @override
  String get signup_invalid_email_format => 'تنسيق البريد الإلكتروني غير صالح';

  @override
  String get signup_failed => 'فشل إنشاء الحساب';

  @override
  String get signup_password_weak =>
      'استخدم 8 أحرف أو أكثر مع مزيج من\nحروف كبيرة وصغيرة وأرقام';

  @override
  String get signup_age_checkbox => 'عمري 18 سنة أو أكثر';

  @override
  String get signup_button => 'إنشاء حساب';

  @override
  String get signup_have_account => 'لديك حساب بالفعل؟';

  @override
  String get signup_login_link => 'تسجيل الدخول';

  @override
  String get google_signup => 'التسجيل باستخدام Google';

  @override
  String get check_18yo_checkbox =>
      'يرجى تأكيد أنك تبلغ من العمر 18 عامًا أو أكثر';

  @override
  String get signup_account_created_success => 'تم إنشاء الحساب بنجاح!';

  @override
  String get signup_email_verification_message =>
      'لقد أرسلنا رابط التحقق إلى بريدك الإلكتروني.\nيرجى التحقق من صندوق الوارد والضغط على الرابط لتأكيد بريدك الإلكتروني قبل تسجيل الدخول.\nإذا لم تكن الرسالة موجودة في صندوق الوارد، يرجى التحقق من مجلد الرسائل غير المرغوب فيها أو المهملات.';

  @override
  String get signup_username_rules =>
      'يجب أن يحتوي اسم المستخدم على حرف واحد على الأقل.\nويمكن أن يتضمن فقط الأحرف، الأرقام، النقاط (.)،\nوالشرطة السفلية (_)، بدون مسافات.';

  @override
  String get signup_username_min_length =>
      'يجب أن يكون اسم المستخدم 3 أحرف على الأقل أو أكثر';

  @override
  String get signup_all_details_valid => 'يجب أن تكون جميع التفاصيل صالحة';

  @override
  String get forgot_title => 'استعادة كلمة المرور';

  @override
  String get forgot_subtitle =>
      'أدخل بريدك الإلكتروني لإعادة تعيين كلمة المرور';

  @override
  String get forgot_email_label => 'البريد الإلكتروني';

  @override
  String get forgot_reset_button => 'إعادة تعيين كلمة المرور';

  @override
  String get forgot_email_empty => 'يرجى إدخال بريدك الإلكتروني';

  @override
  String get forgot_send_otp_code => 'إرسال رمز التحقق';

  @override
  String get forgot_failed_otp =>
      'فشل في إرسال رمز التحقق، حاول مرة أخرى لاحقًا';

  @override
  String get forgot_network_error =>
      'خطأ في الشبكة، يرجى التحقق من اتصال الإنترنت';

  @override
  String get verify_title => 'التحقق برمز التأكيد';

  @override
  String get verify_subtitle =>
      'يرجى تفقد بريدك الإلكتروني للحصول على رمز التحقق';

  @override
  String get verify_button => 'تأكيد';

  @override
  String get verify_resend => 'إعادة إرسال الرمز';

  @override
  String get verify_reset_password_email => 'بريد إعادة تعيين كلمة المرور';

  @override
  String get verify_reset_password_info =>
      'لقد أرسلنا لك بريدًا لإعادة تعيين كلمة المرور،\nإذا لم تجده في بريدك الوارد، فتحقق من مجلد الرسائل غير المرغوب فيها أو المهملات.';

  @override
  String get verify_invalid_code =>
      'رمز غير صالح أو منتهي الصلاحية، يرجى المحاولة مرة أخرى';

  @override
  String get verify_new_otp_sent => 'تم إرسال رمز التحقق الجديد بنجاح';

  @override
  String get verify_failed_resend_otp =>
      'فشل في إعادة إرسال رمز التحقق، حاول مرة أخرى لاحقًا';

  @override
  String get verify_wait_timer =>
      'يرجى الانتظار حتى ينتهي المؤقت للحصول على رمز تحقق جديد';

  @override
  String get reset_password_changed_title => 'تم تغيير كلمة المرور بنجاح';

  @override
  String get reset_password_changed_message =>
      'يرجى تسجيل الدخول باستخدام كلمة المرور الجديدة للوصول إلى التطبيق';

  @override
  String get reset_password_failed => 'فشل في تغيير كلمة المرور';

  @override
  String get reset_password_error => 'حدث خطأ أثناء إعادة تعيين كلمة المرور';

  @override
  String get reset_title => 'إعادة تعيين كلمة المرور';

  @override
  String get reset_subtitle => 'أدخل كلمة المرور الجديدة وأكدها';

  @override
  String get reset_new_password_label => 'كلمة المرور الجديدة';

  @override
  String get reset_confirm_password_label => 'تأكيد كلمة المرور';

  @override
  String get reset_button => 'إعادة تعيين كلمة المرور';

  @override
  String get reset_password_match => 'يجب أن تتطابق كلمتا المرور';

  @override
  String get home_what_item_question => 'ما العنصر الذي تريد الإبلاغ عنه؟';

  @override
  String get home_lost_button => 'مفقود';

  @override
  String get home_found_button => 'معثور عليه';

  @override
  String get home_stats_brand => 'وُجِد ';

  @override
  String get home_stats_suffix => 'بالأرقام';

  @override
  String get home_stat_reports_title => 'التقارير\nالمقدمة';

  @override
  String get home_stat_items_title => 'العناصر\nالمستعادة';

  @override
  String get home_stat_matches_title => 'التطابقات\nالموجودة';

  @override
  String get home_stat_reports_value => '+2100';

  @override
  String get home_stat_items_value => '+1600';

  @override
  String get home_stat_matches_value => '+1800';

  @override
  String get home_card_title => 'آلة تحضير القهوة';

  @override
  String get home_card_subtitle => 'راجع تقريرك السابق';

  @override
  String get home_card_view_arrow_aria => 'عرض تفاصيل التقرير';

  @override
  String get home_note =>
      'ابقَ آمنًا، قابل الآخرين في الأماكن العامة، وتجنّب مشاركة معلوماتك الشخصية.';

  @override
  String get navbar_home => 'الرئيسية';

  @override
  String get navbar_history => 'السجل';

  @override
  String get navbar_messages => 'الرسائل';

  @override
  String get navbar_profile => 'الملف الشخصي';

  @override
  String get notifications_title => 'الإشعارات';

  @override
  String get notifications_expired_title => 'انتهت صلاحية التقرير ';

  @override
  String get notifications_expired_body =>
      'انتهت صلاحية تقريرك عن Item5 بسبب عدم\nتأكيد الاستلام.';

  @override
  String get notifications_new_match_title => 'تم العثور على تطابق جديد';

  @override
  String get notifications_new_match_body =>
      'تم العثور على تطابق جديد لتقريرك عن\nآلة تحضير القهوة.';

  @override
  String get notifications_expiring_soon_title => 'تقرير سينتهي قريبًا ';

  @override
  String get notifications_expiring_soon_body =>
      'سينتهي تقريرك عن آلة تحضير القهوة خلال 5 أيام\nما لم تقم بتجديده أو قبول تطابق.';

  @override
  String get notifications_time_2d => 'قبل يومين';

  @override
  String get notifications_time_6d => 'قبل 6 أيام';

  @override
  String get notifications_time_9d => 'قبل 9 أيام';

  @override
  String get report_found_title => 'الإبلاغ عن عنصر معثور عليه';

  @override
  String get report_lost_title => 'الإبلاغ عن عنصر مفقود';

  @override
  String get report_required_details => 'يرجى تعبئة جميع الحقول المطلوبة';

  @override
  String get report_title_label => 'العنوان ';

  @override
  String get report_title_hint => 'مثال: محفظة بنية';

  @override
  String get report_photo_label => 'الصورة ';

  @override
  String get report_location_label => 'الموقع ';

  @override
  String get report_location_button_hint => 'انقر هنا لإضافة موقع';

  @override
  String get report_description_label => 'الوصف ';

  @override
  String get report_description_hint =>
      'صف عنصرَك (النوع، اللون، العلامة التجارية، إلخ)';

  @override
  String report_counter_left(int remaining) {
    return 'عدد الأحرف المتبقية: $remaining';
  }

  @override
  String get report_submit_button => 'إرسال';

  @override
  String get report_upload_photos_hint => 'انقر هنا لإضافة ما يصل إلى صورتين';

  @override
  String get sheet_choose_location_title => 'اختر موقعًا';

  @override
  String get sheet_current_location_title => 'موقعك الحالي';

  @override
  String get sheet_current_location_sub => 'جامعة الملك سعود، الرياض 12372';

  @override
  String get sheet_choose_manually => 'اختر يدويًا';

  @override
  String get sheet_confirm => 'تأكيد';

  @override
  String get sheet_send => 'إرسال';

  @override
  String get history_title => 'السجل';

  @override
  String get history_tab_lost => 'مفقود';

  @override
  String get history_tab_found => 'معثور عليه';

  @override
  String get item_title_coffee_brewer => 'آلة تحضير القهوة';

  @override
  String get item_title_coffee_mug => 'كوب قهوة';

  @override
  String get details_location_label => 'الموقع';

  @override
  String get details_description_label => 'الوصف';

  @override
  String get lost_found_matches_title => 'التطابقات الموجودة';

  @override
  String match_confidence(int percent) {
    return '$percent% عنصرُك';
  }

  @override
  String get dialog_are_you_sure_item => 'هل أنت متأكد أن هذا هو عنصرُك؟';

  @override
  String get dialog_accept_match_note =>
      'قبول هذا التطابق سيخفي الباقي. إذا لم يكن عنصرَك، اضغط \"سحب\" لإعادتها.';

  @override
  String get dialog_are_you_sure => 'هل أنت متأكد؟';

  @override
  String get dialog_remove_permanently_note =>
      'سيُحذف هذا التطابق نهائيًا. تابع فقط إذا كنت متأكدًا أنه ليس عنصرَك.';

  @override
  String get dialog_confirm_received_note =>
      'تابع فقط إذا كنت متأكدًا أنك استلمت غرضك.';

  @override
  String get report_cancel_dialog_info =>
      'سيتم حذف هذا البلاغ ولن يتم معالجته بعد الآن.';

  @override
  String get btn_accept => 'قبول';

  @override
  String get btn_reject => 'رفض';

  @override
  String get btn_revoke => 'سحب';

  @override
  String get btn_confirm => 'تأكيد';

  @override
  String get btn_cancel => 'إلغاء';

  @override
  String get btn_delete => 'حذف';

  @override
  String get btn_renew => 'تجديد';

  @override
  String get btn_confirm_receipt => 'تأكيد الاستلام';

  @override
  String get btn_continue => 'متابعة';

  @override
  String get toast_congrats => 'تهانينا!';

  @override
  String get toast_got_item_back => 'لقد استعدت عنصرَك!\nاستمتع بعودته بأمان';

  @override
  String get submit_success_title => 'تم! تم إرسال تقريرك\nبنجاح';

  @override
  String get appTitle => 'وُجد';

  @override
  String get messages_title => 'الرسائل';

  @override
  String get messages_you_prefix => 'أنت:';

  @override
  String get messages_typing => 'يكتب...';

  @override
  String get messages_items_matched => 'تم تطابق عناصرِك!';

  @override
  String get action_block => 'حظر';

  @override
  String get chat_hello_found_item => 'مرحبًا، أعتقد أنني وجدت عنصرَك';

  @override
  String get chat_great_do => 'رائع! لنفعل ذلك';

  @override
  String get chat_lets_decide => 'دعنا نقرر مكانًا ووقتًا للقاء!';

  @override
  String get chat_yes_match => 'نعم في الواقع إنه يطابق';

  @override
  String get chat_id_request =>
      'يبدو أنه يخصني. بالداخل يجب أن تكون هناك بطاقة طالب باسم Ghaida Mo. هل يمكنك التحقق إذا كانت متطابقة؟';

  @override
  String get chat_hello => 'مرحبًا!';

  @override
  String get chat_date => 'اليوم';

  @override
  String get chat_hint => 'اكتب رسالتك...';

  @override
  String get profile_title => 'الملف الشخصي';

  @override
  String get menu_switch_language => 'تبديل اللغة';

  @override
  String get language_en => 'English';

  @override
  String get language_ar => 'العربية';

  @override
  String get action_log_out => 'تسجيل الخروج';

  @override
  String get blocked_users => 'المستخدمون المحظورون';

  @override
  String get unblock_user => 'إلغاء الحظر';

  @override
  String get unblock_dialog_title => 'إلغاء الحظر';

  @override
  String unblock_user_confirm(String name) {
    return 'هل أنت متأكد أنك تريد إلغاء حظر $name؟';
  }

  @override
  String get label_first_name => 'الاسم الأول';

  @override
  String get label_last_name => 'اسم العائلة';

  @override
  String get label_phone_number => 'رقم الجوال';

  @override
  String get placeholder_not_provided => 'غير متوفر';

  @override
  String get edit_profile_title => 'تعديل الملف الشخصي';

  @override
  String get edit_profile_change_picture => 'تغيير صورة الملف الشخصي';

  @override
  String get action_done => 'تم';

  @override
  String get onboarding_skip => 'تخطي';

  @override
  String get onboarding_next => 'التالي';

  @override
  String get onboarding_done => 'تم';

  @override
  String get btn_send => 'إرسال';

  @override
  String get btn_ok => 'حسنًا';

  @override
  String get common_error_generic => 'عذرًا، حدث خطأ ما';

  @override
  String get common_empty => 'لا توجد معلومات بعد';

  @override
  String get common_untitled => 'بدون عنوان';

  @override
  String get label_value_missing => 'غير متوفر';

  @override
  String get phone_placeholder => '5XXXXXXXX';

  @override
  String get no_new_data_entered => 'لا توجد بيانات جديدة';

  @override
  String get profile_update_success => 'تم تحديث الملف الشخصي بنجاح!';

  @override
  String get profile_update_failed => 'فشل تحديث الملف الشخصي';

  @override
  String get first_name_too_short => 'يجب أن يكون الاسم الأول حرفين فأكثر';

  @override
  String get last_name_too_short => 'يجب أن يكون اسم العائلة حرفين فأكثر';

  @override
  String get phone_invalid_length => 'يجب أن يتكون رقم الجوال من 9 أرقام';

  @override
  String get history_no_found_reports => 'لا توجد بلاغات عثور حتى الآن';

  @override
  String get history_no_lost_reports => 'لا توجد بلاغات فقدان حتى الآن';

  @override
  String get status_ongoing => 'قيد المعالجة';

  @override
  String get status_done => 'مكتمل';

  @override
  String get status_rejected => 'مرفوض';

  @override
  String get status_match_found => 'تم العثور على تطابق';

  @override
  String get status_expired => 'منتهي';

  @override
  String get pick_location_enable_service_title => 'خدمة الموقع';

  @override
  String get pick_location_enable_service_body => 'يرجى تفعيل خدمات الموقع.';

  @override
  String get pick_location_permission_title => 'إذن الموقع';

  @override
  String get pick_location_permission_body => 'يرجى السماح بإذن الموقع.';

  @override
  String get pick_location_permission_settings_body =>
      'يرجى تفعيل إذن الموقع من الإعدادات.';

  @override
  String get pick_location_error_title => 'خطأ في الموقع';

  @override
  String get pick_location_error_body =>
      'تعذّر الحصول على الموقع الحالي. يرجى المحاولة مرة أخرى أو اختيار موقعك يدويًا.';

  @override
  String get pick_location_tap_hint => 'اضغط على الخريطة لاختيار موقع';

  @override
  String get title_indicator => 'أحرف متبقية';

  @override
  String get snackbar_fill_fields => 'يرجى تعبئة العنوان والوصف';

  @override
  String get snackbar_pick_location => 'يرجى تحديد الموقع';

  @override
  String get snackbar_add_photos => 'يرجى إضافة صورة واحدة على الأقل';

  @override
  String snackbar_submit_failed(Object error) {
    return 'فشل الإرسال: $error';
  }

  @override
  String get snackbar_location_set => 'تم تحديد الموقع بنجاح';

  @override
  String get snackbar_location_not_selected => 'لم يتم تحديد الموقع';

  @override
  String get report_submitting => 'جاري الإرسال…';

  @override
  String get outside_riyadh => 'خارج الرياض';

  @override
  String get outside_dialog => 'موقعك خارج حدود الرياض.';

  @override
  String get error_allow_photo_access =>
      'يرجى السماح بالوصول إلى الصور لتحميل الصور';

  @override
  String get error_max_photos => 'يمكنك تحميل صورتين فقط كحد أقصى';

  @override
  String get error_save_gallery => 'فشل في حفظ الصورة في المعرض';

  @override
  String get error_duplicate_photo => 'لقد قمت بتحميل هذه الصورة بالفعل';

  @override
  String get error_enable_photo_access =>
      'يرجى تفعيل الوصول إلى الصور من الإعدادات';

  @override
  String get error_create_report => 'فشل في إنشاء البلاغ';

  @override
  String get error_submit_report => 'فشل في إرسال البلاغ';

  @override
  String get report_sumbitted_successfully => 'تم بنجاح! تم إرسال بلاغك بنجاح';
}
