import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController controllerFirstName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();
  TextEditingController controllerPhoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

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
        actions: [
          TextButton(
            onPressed: () {
              onDonePressed();
            },
            child: Text(
              t.action_done,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 95,
                height: 95,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade500,
                ),
                child: const Icon(IconlyBold.profile,
                    color: Colors.white, size: 70),
              ),
              const SizedBox(height: 10.0),
              Text(
                t.edit_profile_change_picture,
                style: const TextStyle(
                  color: Color.fromRGBO(46, 23, 21, 1),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20.0),

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
              _buildTextField(controllerFirstName, TextInputType.text,
                  [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))],
                  hint: t.placeholder_not_provided),

              const SizedBox(height: 20.0),

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
              _buildTextField(controllerLastName, TextInputType.text,
                  [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))],
                  hint: t.placeholder_not_provided),

              const SizedBox(height: 20.0),

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
              _buildTextField(controllerPhoneNumber, TextInputType.phone,
                  [FilteringTextInputFormatter.digitsOnly],
                  hint: t.placeholder_not_provided),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller,
      TextInputType type, List<TextInputFormatter> formatters,
      {required String hint}) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: TextField(
        controller: controller,
        keyboardType: type,
        inputFormatters: formatters,
        autocorrect: false,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color.fromRGBO(46, 23, 21, 1),
              width: 2.0,
            ),
          ),
          suffixIcon: Icon(
            IconlyBold.edit,
            color: Colors.grey.shade400,
          ),
        ),
      ),
    );
  }

  onDonePressed() {
    final firstName = controllerFirstName.text.trim();
    final lastName = controllerLastName.text.trim();
    final phoneNumber = controllerPhoneNumber.text.trim();

    Navigator.pop(context, {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
    });
  }
}
