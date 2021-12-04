import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_admin/Functions/delivery_partner_auth.dart';
import 'package:razorpay_admin/Helpers/button.dart';
import 'package:razorpay_admin/Helpers/colors.dart';
import 'package:razorpay_admin/Helpers/style.dart';
import 'package:razorpay_admin/Helpers/textfield_deco.dart';
import 'package:razorpay_admin/Screens/DeliveryPartner/delivery_home.dart';
import 'package:razorpay_admin/Widgets/dialogs.dart';
import 'package:razorpay_admin/Helpers/global.dart' as global;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationController;

  final _phoneFormKey = GlobalKey<FormState>();
  final _otpFormKey = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;
  Dialogs dialogs = Dialogs();

  final TextEditingController _otpCtrl = TextEditingController(),
      _phoneCtrl = TextEditingController();

  bool _phoneVerified = false;
  String? verId;
  String? uid;

  void verify() {
    if (_phoneFormKey.currentState!.validate()) {
      dialogs.loading(context, content: 'Verifying...');

      DeliveryPartnerAuth.verifyUser(_phoneCtrl.text.trim())
          .then((value) async {
        dialogs.dismiss(context);

        if (value == true) {
          setState(() {
            _phoneVerified = true;
            animationController.forward();
          });

          await Future.delayed(const Duration(seconds: 2));
          login();
        } else {
          dialogs.error(
            context: context,
            content: 'This number is not added by Admin',
          );
        }
      }).catchError((e) {
        dialogs.dismiss(context);
        dialogs.error(context: context);
      });
    }
  }

  var _sendingOTP = false;

  void login() async {
    String phone = _phoneCtrl.text.trim();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      dialogs.loading(context, content: 'Sending OTP. Please Wait...');
      _sendingOTP = true;
    });

    await auth.verifyPhoneNumber(
      phoneNumber: '+91$phone',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          if (_sendingOTP == true) {
            dialogs.dismiss(context);
            _sendingOTP = false;
          }

          dialogs.loading(context, content: 'Logging In...');

          _saveUser();
        });
      },
      verificationFailed: (FirebaseAuthException error) {
        if (_sendingOTP == true) {
          dialogs.dismiss(context);
          _sendingOTP = false;
        }

        if (error.code == 'invalid-phone-number') {
          dialogs.error(
            context: context,
            content: 'Enter a valid Phone Number',
          );
        } else {
          dialogs.error(context: context);
        }
      },
      codeSent: (String verificationId, forceResendingToken) {
        if (_sendingOTP == true) {
          dialogs.dismiss(context);
          _sendingOTP = false;
        }
        setState(() {
          verId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (verificationId) {},
      timeout: const Duration(seconds: 60),
    );
  }

  void manualOtp() async {
    try {
      dialogs.loading(context, content: 'Logging In');
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verId!.trim(),
        smsCode: _otpCtrl.text.trim(),
      );

      UserCredential userCredential =
          await auth.signInWithCredential(credential).catchError((e) {});

      _saveUser();
    } catch (error) {
      dialogs.dismiss(context);
      dialogs.error(context: context);
    }
  }

  void _saveUser() async {
    QuerySnapshot querySnap = await FirebaseFirestore.instance
        .collection('DeliveryUsers')
        .where('phone', isEqualTo: _phoneCtrl.text.trim())
        .get();

    final data = querySnap.docs[0].data() as Map;

    global.deliveryId = data['id'];

    Navigator.pushNamedAndRemoveUntil(
      context,
      DeliveryHome.pg,
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: width * 0.2),
                  Text(
                    'Login to Continue',
                    style: TextStyle(
                      fontSize: width * 0.07,
                      color: green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: width * 0.45),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: Form(
                      key: _phoneFormKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _phoneCtrl,
                            decoration: TextFieldDecoration.rRectDecoration(
                              width: width,
                              hint: 'Enter Phone Number',
                            ).copyWith(
                              hintStyle: greenText,
                              counterText: '',
                              icon: Icon(
                                Icons.phone,
                                color: green,
                                size: width * 0.06,
                              ),
                            ),
                            enabled: !_phoneVerified,
                            maxLength: 10,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Phone Number';
                              }
                              if (value.length != 10) {
                                return 'Enter a valid Phone Number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: width * 0.05),
                        ],
                      ),
                    ),
                  ),
                  _phoneVerified
                      ? Transform(
                          transform: Matrix4.translationValues(
                              animation.value * width, 0, 0),
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.18),
                            child: Form(
                              key: _otpFormKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _otpCtrl,
                                    decoration:
                                        TextFieldDecoration.rRectDecoration(
                                      width: width,
                                      hint: 'Enter OTP',
                                    ).copyWith(
                                      hintStyle: greenText,
                                      counterText: '',
                                    ),
                                    maxLength: 6,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.number,
                                    obscureText: true,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter OTP';
                                      }
                                      if (value.length != 6) {
                                        return 'Enter a valid OTP';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: width * 0.05),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Didn\'t Receive OTP?',
                                        style: greenText,
                                      ),
                                      SizedBox(width: width * 0.01),
                                      InkWell(
                                        onTap: login,
                                        child: Text(
                                          'Resend',
                                          style: greenText.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: width * 0.08),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  LoginButton(
                    text: _phoneVerified ? 'Login' : 'Verify',
                    onPressed: _phoneVerified ? manualOtp : verify,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
