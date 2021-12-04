import 'package:flutter/material.dart';
import 'package:razorpay_admin/Functions/admin_verification.dart';
import 'package:razorpay_admin/Helpers/button.dart';
import 'package:razorpay_admin/Helpers/colors.dart';
import 'package:razorpay_admin/Helpers/textfield_deco.dart';
import 'package:razorpay_admin/Screens/home.dart';
import 'package:razorpay_admin/Widgets/dialogs.dart';

class AdminPasscode extends StatefulWidget {
  const AdminPasscode({Key? key}) : super(key: key);

  @override
  _AdminPasscodeState createState() => _AdminPasscodeState();
}

class _AdminPasscodeState extends State<AdminPasscode> {
  Dialogs dialogs = Dialogs();

  final TextEditingController _passCtrl = TextEditingController();

  void enterPin() async {
    if (_passCtrl.text.trim().isNotEmpty) {
      dialogs.loading(context, content: 'Validating');

      await AdminVerification.login(int.parse(_passCtrl.text.trim()))
          .then((value) {
        dialogs.dismiss(context);

        if (value == true) {
          Navigator.pushReplacementNamed(context, Home.pg);
        } else {
          dialogs.error(context: context, content: 'Enter a valid Passcode');
        }
      }).catchError((error) {
        dialogs.dismiss(context);
        dialogs.error(context: context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: width * 0.2),
                Text(
                  'Passcode',
                  style: TextStyle(
                    fontSize: width * 0.07,
                    color: green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text('Enter the 4-digit passcode to continue'),
                SizedBox(height: width * 0.45),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.25),
                  child: TextField(
                    controller: _passCtrl,
                    decoration: TextFieldDecoration.rRectDecoration(
                      width: width,
                      hint: 'Passcode',
                    ).copyWith(counterText: ''),
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                SizedBox(height: width * 0.05),
                LoginButton(
                  text: 'Enter',
                  onPressed: enterPin,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
