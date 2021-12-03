import 'package:flutter/material.dart';
import 'package:razorpay_user/Helpers/buttons.dart';
import 'package:razorpay_user/Helpers/colors.dart';
import 'package:razorpay_user/Helpers/custom_icons.dart';
import 'package:razorpay_user/Helpers/style.dart';
import 'package:razorpay_user/Helpers/textfield_decoration.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
      ),
      children: [
        Text(
          'Your Profile',
          style: greenBoldText.copyWith(
            fontSize: width * 0.0475,
          ),
          textAlign: TextAlign.center,
        ),
        Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  CustomIcons.edit,
                  color: green,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: width * 0.43,
              width: width * 0.43,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: AssetImage('images/Avatar1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: width * 0.03),
              child: InkWell(
                onTap: () {},
                child: const Text(
                  'Change Profile',
                ),
              ),
            ),
            SizedBox(height: width * 0.03),
            const Text(
              'My Referral Code : ABCDEF',
              style: greenText,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: width * 0.07),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
              ),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: TextFieldDecoration.rRectDecoration(
                        hint: 'Name',
                        width: width,
                      ),
                      readOnly: true,
                    ),
                    SizedBox(height: width * 0.06),
                    TextFormField(
                      decoration: TextFieldDecoration.rRectDecoration(
                        hint: 'Phone No.',
                        width: width,
                      ),
                      readOnly: true,
                    ),
                    SizedBox(height: width * 0.06),
                    TextFormField(
                      decoration: TextFieldDecoration.rRectDecoration(
                        hint: 'Address',
                        width: width,
                      ),
                      readOnly: true,
                    ),
                    SizedBox(height: width * 0.03),
                    SolidButton(
                      name: 'Update',
                      onPressed: () {},
                    ),
                    SizedBox(height: width * 0.03),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
