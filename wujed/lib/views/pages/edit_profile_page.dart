import 'dart:async';
import 'dart:io'; // Required for File

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

// Imports for image picking and storage
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

// Shared sanitising helpers used everywhere in the app
import 'package:wujed/utils/input_validators.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  /// Currently logged-in user (Firebase Auth)
  final user = FirebaseAuth.instance.currentUser!;

  /// Combined user data from:
  ///   users/{uid}/public/data  +  users/{uid}/private/data
  var userData;

  /// Shows full-screen loader while we update Firestore
  bool isUpdating = false;

  // 🖼️ New: Local file object for the chosen profile image
  File? _pickedImageFile;

  /// Text controllers for each editable field
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerPhoneNumber = TextEditingController();

  /// Flags + warning messages for live validation
  bool updateMade = false;

  String usernameWarning = "";
  bool usernameValid = false;

  String firstNameWarning = "";
  bool firstNameValid = false;

  String lastNameWarning = "";
  bool lastNameValid = false;

  String phoneNumberWarning = "";
  bool phoneNumberValid = false;

  /// Timer used to debounce Firestore username check
  Timer? usernameTimer;

  @override
  void initState() {
    super.initState();

    // Attach listeners so we validate while the user types.
    _controllerUsername.addListener(validateUsername);
    _controllerFirstName.addListener(validateFirstName);
    _controllerLastName.addListener(validateLastName);
    _controllerPhoneNumber.addListener(validatePhoneNumber);

    // Load user data from Firestore when page opens.
    _loadUserData();
  }

  // Dispose the controllers and timer when the widget is removed
  @override
  void dispose() {
    _controllerUsername.dispose();
    _controllerFirstName.dispose();
    _controllerLastName.dispose();
    _controllerPhoneNumber.dispose();
    usernameTimer?.cancel();
    super.dispose();
  }

  /// Reads user profile from Firestore:
  ///  - public:  username
  ///  - private: first_name, last_name, phone_number, ...
  ///  - New:     profile_photo_url
  Future _loadUserData() async {
    try {
      final publicDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('public')
          .doc('data')
          .get();

      final privateDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('private')
          .doc('data')
          .get();

      if (publicDoc.exists && privateDoc.exists) {
        setState(() {
          // Merge public + private fields into one map
          userData = {...publicDoc.data()!, ...privateDoc.data()!};

          // Pre-fill controllers with existing values
          _controllerUsername.text = userData['username'] ?? '';
          _controllerFirstName.text = userData['first_name'] ?? '';
          _controllerLastName.text = userData['last_name'] ?? '';
          _controllerPhoneNumber.text = userData['phone_number'] ?? '';
        });
      }
    } catch (e) {
      // If something goes wrong, just print it (no crash)
      print('Error loading user data: $e');
    }
  }

  Future<bool> _requestPhotoPermission() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    final t = AppLocalizations.of(context);

    if (ps.isAuth) {
      // Permission already granted
      return true;
    } else if (ps.hasAccess) {
      // Old Android versions (pre-13)
      return true;
    } else {
      // Permission denied → show message and open settings
      _showSnackBar(t.error_enable_photo_access, Icons.warning_rounded);
      await PhotoManager.openSetting();
      return false;
    }
  }

  // 🖼️ New: Function to pick and upload image to Firebase Storage
  Future<void> _pickAndUploadImage() async {
    final t = AppLocalizations.of(context);
    FocusScope.of(context).unfocus();

    final hasPermission = await _requestPhotoPermission();
    if (!hasPermission) {
      _showSnackBar(t.error_allow_photo_access, Icons.warning_rounded);
      return;
    }

    final result = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets: 1,
        requestType: RequestType.image,
        specialItemPosition: SpecialItemPosition.prepend,
        specialItemBuilder: (context, _, __) {
          return GestureDetector(
            onTap: () async {
              final picker = ImagePicker();
              final picked = await picker.pickImage(
                source: ImageSource.camera,
                imageQuality: 85,
              );

              if (picked != null) {
                final file = File(picked.path);

                try {
                  final bytes = await file.readAsBytes();

                  final tempDir = await getTemporaryDirectory();
                  final tempPath =
                      '${tempDir.path}/wujed_${DateTime.now().millisecondsSinceEpoch}.jpg';
                  final tempFile = await File(tempPath).writeAsBytes(bytes);

                  await GallerySaver.saveImage(tempFile.path);

                  setState(() {
                    _pickedImageFile = file; // صورة واحدة فقط
                  });

                  Navigator.pop(context); // يقفل البيكر
                } catch (e) {
                  _showSnackBar(t.error_save_gallery, Icons.warning_rounded);
                }
              }
            },
            child: const Center(
              child: Icon(Icons.camera_alt, size: 42, color: Colors.grey),
            ),
          );
        },
      ),
    );

    if (result != null && result.isNotEmpty) {
      final file = await result.first.file;

      if (file != null) {
        setState(() {
          _pickedImageFile = file; // صورة واحدة فقط
        });
      }
    }
  }

  // 🖼️ Helper to display the current image (local or remote)
  Widget _buildProfileAvatar() {
    final String? imageUrl = userData['profile_photo'];
    // final t = AppLocalizations.of(context); // Not needed here

    // If the user picked a new image, show it locally (before update)
    if (_pickedImageFile != null) {
      return CircleAvatar(
        radius: 47.5,
        backgroundImage: FileImage(_pickedImageFile!),
      );
    }

    // If there is an existing image URL, show it from the network
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return CircleAvatar(
        radius: 47.5,
        backgroundImage: NetworkImage(imageUrl),
        onBackgroundImageError: (exception, stackTrace) {
          // Fallback if network image fails
          print('Network image failed to load: $exception');
          // Fallback to placeholder icon
        },
      );
    }

    // Default placeholder
    return Container(
      width: 95,
      height: 95,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade500,
      ),
      child: const Icon(IconlyBold.profile, color: Colors.white, size: 70),
    );
  }

  @override
  Widget build(BuildContext context) {
    // While we are still loading profile data, show a loader screen
    if (userData == null) {
      return const Scaffold(
        backgroundColor: Color.fromRGBO(249, 249, 249, 1),
        body: Center(
          child: CircularProgressIndicator(
            color: Color.fromRGBO(255, 175, 0, 1),
          ),
        ),
      );
    }

    final t = AppLocalizations.of(context)!; // Use !

    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
        surfaceTintColor: Colors.transparent,
        title: Title(
          color: const Color.fromRGBO(46, 23, 21, 1),
          child: Text(
            t.edit_profile_title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            // pop and tell previous page that nothing changed
            Navigator.pop(context, false);
          },
        ),
        actions: [
          // "Done" button → triggers Firestore updates
          TextButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              onDonePressed();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                t.action_done,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Main content
          GestureDetector(
            // Hide keyboard when tapping outside fields
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // 🖼️ UPDATED: Avatar with Image picking logic
                    GestureDetector(
                      onTap: _pickAndUploadImage,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          _buildProfileAvatar(),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(255, 175, 0, 1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              IconlyBold.camera,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Original text is now wrapped in a button
                    const SizedBox(height: 10.0),
                    TextButton(
                      onPressed: _pickAndUploadImage,
                      child: Text(
                        t.edit_profile_change_picture,
                        style: const TextStyle(
                          color: Color.fromRGBO(46, 23, 21, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    // ---------------- USERNAME ----------------
                    Row(
                      children: [
                        Text(
                          t.signup_username_label,
                          style: const TextStyle(
                            color: Color.fromRGBO(46, 23, 21, 1),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    _buildTextField(
                      _controllerUsername,
                      TextInputType.text,
                      [
                        // Only allow letters, digits, dot and underscore
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z0-9._]'),
                        ),
                      ],
                      hint: userData['username'],
                    ),
                    if (usernameWarning != '')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            usernameWarning,
                            style: const TextStyle(
                              color: Color.fromRGBO(211, 47, 47, 1),
                            ),
                          ),
                        ],
                      ),

                    const SizedBox(height: 20.0),

                    // ---------------- FIRST NAME ----------------
                    Row(
                      children: [
                        Text(
                          t.label_first_name,
                          style: const TextStyle(
                            color: Color.fromRGBO(46, 23, 21, 1),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    _buildTextField(
                      _controllerFirstName,
                      TextInputType.text,
                      [
                        // Only English letters allowed here
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z\u0600-\u06FF\s]'),
                        ),
                      ],
                      hint: userData['first_name'] == ''
                          ? t.placeholder_not_provided
                          : userData['first_name'],
                    ),
                    if (firstNameWarning != '')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            firstNameWarning,
                            style: const TextStyle(
                              color: Color.fromRGBO(211, 47, 47, 1),
                            ),
                          ),
                        ],
                      ),

                    const SizedBox(height: 20.0),

                    // ---------------- LAST NAME ----------------
                    Row(
                      children: [
                        Text(
                          t.label_last_name,
                          style: const TextStyle(
                            color: Color.fromRGBO(46, 23, 21, 1),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    _buildTextField(
                      _controllerLastName,
                      TextInputType.text,
                      [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z\u0600-\u06FF\s]'),
                        ),
                      ],
                      hint: userData['last_name'] == ''
                          ? t.placeholder_not_provided
                          : userData['last_name'],
                    ),
                    if (lastNameWarning != '')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            lastNameWarning,
                            style: const TextStyle(
                              color: Color.fromRGBO(211, 47, 47, 1),
                            ),
                          ),
                        ],
                      ),

                    const SizedBox(height: 20.0),

                    // ---------------- PHONE NUMBER ----------------
                    Row(
                      children: [
                        Text(
                          t.label_phone_number,
                          style: const TextStyle(
                            color: Color.fromRGBO(46, 23, 21, 1),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    _buildTextField(
                      _controllerPhoneNumber,
                      TextInputType.phone,
                      [
                        // Only digits, we prepend +966 ourselves
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      hint: userData['phone_number'] == ''
                          ? t.phone_placeholder
                          : userData['phone_number'],
                      isPhone: true,
                    ),
                    if (phoneNumberWarning != '')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            phoneNumberWarning,
                            style: const TextStyle(
                              color: Color.fromRGBO(211, 47, 47, 1),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),

          // Full-screen loading overlay while we update Firestore
          if (isUpdating)
            Container(
              color: const Color.fromRGBO(0, 0, 0, 0.4),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(255, 175, 0, 1),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Small helper to create nicely styled text fields.
  ///
  /// `isPhone = true` adds the "+966 |" prefix.
  Widget _buildTextField(
    TextEditingController controller,
    TextInputType type,
    List<TextInputFormatter> formatters, {
    required String hint,
    bool isPhone = false,
  }) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: TextField(
        controller: controller,
        keyboardType: type,
        inputFormatters: formatters,
        maxLength: isPhone ? 9 : 20, // 9 digits after +966
        autocorrect: false,
        decoration: InputDecoration(
          counterText: '',
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 16),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color.fromRGBO(46, 23, 21, 1),
              width: 2.0,
            ),
          ),
          suffixIcon: Icon(IconlyBold.edit, color: Colors.grey.shade400),
          prefixIcon: isPhone
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsetsDirectional.only(start: 15, top: 3),
                      child: Text(
                        '+966',
                        style: TextStyle(
                          color: Color.fromRGBO(46, 23, 21, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const VerticalDivider(
                      color: Colors.grey,
                      thickness: 1,
                      width: 10,
                      indent: 10,
                      endIndent: 10,
                    ),
                  ],
                )
              : null,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 60,
            minHeight: 0,
          ),
        ),
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }

  /// Called when the user taps the "Done" button.
  ///
  /// Steps:
  ///  1) Sanitise all input (important!).
  ///  2) Compare with old values; if nothing changed → show message.
  ///  3) For each changed + valid field → update the correct Firestore doc:
  ///       - username → users/{uid}/public/data
  ///       - first/last/phone → users/{uid}/private/data
  ///       - profile_photo_url is updated in _pickAndUploadImage
  ///  4) Show success Snackbar and pop back to profile page.
  Future onDonePressed() async {
    final t = AppLocalizations.of(context)!;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return; // Extra safety: user not logged in

    // --------- 1) SANITISE INPUT BEFORE USING IT ---------

    // Username: trim, limit length, remove < >
    final username = InputValidators.sanitizeText(
      _controllerUsername.text,
      maxLen: 20,
    );

    // First name: same idea, up to 50 chars
    final firstName = InputValidators.sanitizeText(
      _controllerFirstName.text,
      maxLen: 50,
    );

    // Last name: up to 50 chars
    final lastName = InputValidators.sanitizeText(
      _controllerLastName.text,
      maxLen: 50,
    );

    // Phone: we only trim, and rely on digitsOnly + length validation
    final phoneNumber = _controllerPhoneNumber.text.trim();
    //  check if (updateMade)
    bool updateMade = false;

    if (_pickedImageFile != null) {
      setState(() {
        isUpdating = true;
      });

      try {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('users')
            .child(user.uid)
            .child('profile_photo')
            .child('photo.jpg');

        await storageRef.putFile(_pickedImageFile!);
        final url = await storageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('public')
            .doc('data')
            .update({'profile_photo': url});

        updateMade = true;
        _pickedImageFile = null;
      } catch (e) {
        final t = AppLocalizations.of(context)!;

        _showSnackBar(t.error_upload_photo, Icons.warning_rounded);
        setState(() {
          isUpdating = false;
        });
        return;
      }
    }

    // Push sanitised values back into the text fields
    // so the user sees exactly what we are saving.
    _controllerUsername.text = username;
    _controllerFirstName.text = firstName;
    _controllerLastName.text = lastName;
    _controllerPhoneNumber.text = phoneNumber;

    // Run final validation checks before saving
    // validateUsername must be awaited if we need to ensure Firestore check is complete
    // but here we just trigger it and rely on its side effects (setting usernameValid)
    validateUsername();
    validateFirstName();
    validateLastName();
    validatePhoneNumber();

    // Give a small moment for validation (especially Firestore check) to complete
    // In a real app, you might use Future.wait or manage async state better.
    // For simplicity, we wait a tiny bit. If usernameValid is false, it won't proceed.
    await Future.delayed(const Duration(milliseconds: 100));

    try {
      final firestore = FirebaseFirestore.instance;

      // --------- 2) If nothing changed (including image) → show message & return ---------
      if (username == userData['username'].toString().trim() &&
          firstName == userData['first_name'].toString().trim() &&
          lastName == userData['last_name'].toString().trim() &&
          phoneNumber == userData['phone_number'].toString().trim() &&
          updateMade == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(
                  Icons.warning_rounded,
                  color: Color.fromRGBO(46, 23, 21, 1),
                ),
                const SizedBox(width: 10),
                Text(
                  t.no_new_data_entered,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(46, 23, 21, 1),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xFFFFE4B3),
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 10,
          ),
        );
        return;
      }

      // --------- 3) Update ONLY changed + valid fields ---------

      // Username → users/{uid}/public/data
      if (username.isNotEmpty &&
          usernameValid &&
          username != userData['username'].toString().trim()) {
        setState(() {
          isUpdating = true;
        });
        await firestore
            .collection('users')
            .doc(user.uid)
            .collection('public')
            .doc('data')
            .update({'username': username});
        updateMade = true;
      }

      // First name → users/{uid}/private/data
      if (firstName.isNotEmpty &&
          firstNameValid &&
          firstName != userData['first_name'].toString().trim()) {
        setState(() {
          isUpdating = true;
        });
        await firestore
            .collection('users')
            .doc(user.uid)
            .collection('private')
            .doc('data')
            .update({'first_name': firstName});
        updateMade = true;
      }

      // Last name → users/{uid}/private/data
      if (lastName.isNotEmpty &&
          lastNameValid &&
          lastName != userData['last_name'].toString().trim()) {
        setState(() {
          isUpdating = true;
        });
        await firestore
            .collection('users')
            .doc(user.uid)
            .collection('private')
            .doc('data')
            .update({'last_name': lastName});
        updateMade = true;
      }

      // Phone number → users/{uid}/private/data
      if (phoneNumber.isNotEmpty &&
          phoneNumberValid &&
          phoneNumber != userData['phone_number'].toString().trim()) {
        setState(() {
          isUpdating = true;
        });
        await firestore
            .collection('users')
            .doc(user.uid)
            .collection('private')
            .doc('data')
            .update({'phone_number': phoneNumber});
        updateMade = true;
      }

      // --------- 4) If at least one field updated → show success ---------
      if (updateMade) {
        setState(() {
          isUpdating = false;
          _pickedImageFile = null; // Clear local file after success
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Color.fromRGBO(46, 23, 21, 1),
                ),
                const SizedBox(width: 10),
                Text(
                  t.profile_update_success,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(46, 23, 21, 1),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xFFFFE4B3),
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 10,
          ),
        );

        // Pop back to ProfilePage and tell it that something changed (true)
        Navigator.pop(context, true);
      }
    } catch (e) {
      setState(() {
        isUpdating = false;
      });
      // Generic failure message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(
                Icons.warning_rounded,
                color: Color.fromRGBO(46, 23, 21, 1),
              ),
              const SizedBox(width: 10),
              Text(
                t.profile_update_failed,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(46, 23, 21, 1),
                  fontSize: 16,
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFFFFE4B3),
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 10,
        ),
      );
    }
  }
  // ---------------------------------------------------------------------------
  // LIVE VALIDATION HELPERS
  // ---------------------------------------------------------------------------

  /// Username rules:
  bool isUsernameValid(String username) {
    final validUsernameRegex = RegExp(r'^[a-zA-Z0-9._]+$');
    final containLetterRegex = RegExp(r'[a-zA-Z]');
    return validUsernameRegex.hasMatch(username) &&
        containLetterRegex.hasMatch(username);
  }

  /// Validates username while typing + checks Firestore
  void validateUsername() {
    final username = _controllerUsername.text.trim();
    final t = AppLocalizations.of(context)!;

    // Cancel previous timer (debounce)
    if (usernameTimer?.isActive ?? false) usernameTimer!.cancel();

    if (username.isEmpty) {
      if (!mounted) return; // 🛑 Check before setState
      setState(() {
        usernameWarning = '';
        usernameValid = false;
      });
      return;
    }

    if (!isUsernameValid(username)) {
      if (!mounted) return; // 🛑 Check before setState
      setState(() {
        usernameWarning = t.signup_username_rules;
        usernameValid = false;
      });
      return;
    }

    if (username.length < 3) {
      if (!mounted) return; // 🛑 Check before setState
      setState(() {
        usernameWarning = t.signup_username_min_length;
        usernameValid = false;
      });
      return;
    }

    // After 300ms of no typing → check uniqueness in Firestore
    usernameTimer = Timer(const Duration(milliseconds: 300), () async {
      final existingUser = await FirebaseFirestore.instance
          .collectionGroup('public')
          .where('username', isEqualTo: username)
          .get();

      if (existingUser.docs.isNotEmpty) {
        final foundUid = existingUser.docs.first.reference.parent!.parent!.id;
        if (foundUid != user.uid) {
          // Username belongs to someone else → invalid
          if (!mounted) return; // 🛑 Check before setState inside Timer
          setState(() {
            usernameWarning = t.signup_username_taken;
            usernameValid = false;
          });
        } else {
          // Username is ours → allow it
          if (!mounted) return; // 🛑 Check before setState inside Timer
          setState(() {
            usernameWarning = '';
            usernameValid = true;
          });
          return;
        }
      } else {
        if (!mounted)
          return; // 🛑 Check before setState inside Timer (for the success case)
        setState(() {
          usernameWarning = '';
          usernameValid = true;
        });
      }
    });

    // While waiting for Firestore, consider it tentatively valid
    if (!mounted) return; // 🛑 Check before setState
    setState(() {
      usernameWarning = '';
      usernameValid = true;
    });
  }

  /// First name must be at least 2 characters (or empty if user didn't set it).
  void validateFirstName() {
    final firstName = _controllerFirstName.text.trim();
    final t = AppLocalizations.of(context)!;

    if (firstName.isEmpty) {
      if (!mounted) return; // 🛑 Check before setState
      setState(() {
        firstNameWarning = '';
        firstNameValid = false;
      });
      return;
    }

    if (firstName.length < 2) {
      if (!mounted) return; // 🛑 Check before setState
      setState(() {
        firstNameWarning = t.first_name_too_short;
        firstNameValid = false;
      });
      return;
    } else {
      if (!mounted) return; // 🛑 Check before setState
      setState(() {
        firstNameWarning = '';
        firstNameValid = true;
      });
    }
  }

  /// Last name: same rules as first name.
  void validateLastName() {
    final lastName = _controllerLastName.text.trim();
    final t = AppLocalizations.of(context)!;

    if (lastName.isEmpty) {
      if (!mounted) return; // 🛑 Check before setState
      setState(() {
        lastNameWarning = '';
        lastNameValid = false;
      });
      return;
    }

    if (lastName.length < 2) {
      if (!mounted) return; // 🛑 Check before setState
      setState(() {
        lastNameWarning =
            t.first_name_too_short; // Assuming same error message key
        lastNameValid = false;
      });
      return;
    } else {
      if (!mounted) return; // 🛑 Check before setState
      setState(() {
        lastNameWarning = '';
        lastNameValid = true;
      });
    }
  } // ---------------------------------------------------------------------------

  // Missing `validatePhoneNumber` implementation
  // ---------------------------------------------------------------------------
  /// Simple phone number validation (assuming 9 digits after +966).
  void validatePhoneNumber() {
    final phoneNumber = _controllerPhoneNumber.text.trim();
    final t = AppLocalizations.of(context)!;
    // final t = AppLocalizations.of(context)!; // لا نحتاجها الآن

    if (phoneNumber.isEmpty) {
      if (!mounted) return;
      setState(() {
        phoneNumberWarning = '';
        phoneNumberValid = false;
      });
      return;
    }

    // Check if it's exactly 9 digits
    if (phoneNumber.length != 9) {
      if (!mounted) return;
      setState(() {
        phoneNumberWarning = t.validation_phone_9_digits;
        phoneNumberValid = false;
      });
      return;
    } else if (phoneNumber.startsWith('5') == false) {
      if (!mounted) return; // 🛑 Check before setState
      setState(() {
        phoneNumberWarning = t.error_phone_must_start_with_5;
        phoneNumberValid = false;
      });
      return;
    } else {
      if (!mounted) return;
      setState(() {
        phoneNumberWarning = '';
        phoneNumberValid = true;
      });
    }
  }

  void _showSnackBar(String message, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: const Color.fromRGBO(46, 23, 21, 1)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color.fromRGBO(46, 23, 21, 1),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFFFE4B3),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 10,
      ),
    );
  }
}
