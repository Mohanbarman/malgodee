import 'package:ShoppingApp/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ShoppingApp/flavour.dart';
import 'package:ShoppingApp/components/underlined_text.dart';
import 'package:ShoppingApp/components/rounded_icon_container.dart';
import 'package:ShoppingApp/components/input_custom_decoration.dart';

String _callIcon = 'assets/images/call-icon.png';
String _waIcon = 'assets/images/wa-icon.png';

class ContactUsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provider.of<User>(context) == User.unauthenticated
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UnderlinedText('Contact us'),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedIconContainer('Call', _callIcon),
                    SizedBox(width: 30),
                    RoundedIconContainer('Chat', _waIcon),
                  ],
                ),
                SizedBox(height: 30),
              ],
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: ScreenPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UnderlinedText('Edit contact number'),
                  SizedBox(height: ScreenPadding * 2),
                  Row(
                    children: [
                      Text('Calling number', style: LoginFormLabelStyle)
                    ],
                  ),
                  SizedBox(height: ScreenPadding),
                  inputCustomDeocration(
                    TextField(
                      controller: TextEditingController(text: '8098018239'),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenPadding),
                  Row(
                    children: [
                      Text('Whatsapp number', style: LoginFormLabelStyle)
                    ],
                  ),
                  SizedBox(height: ScreenPadding),
                  inputCustomDeocration(
                    TextField(
                      controller: TextEditingController(text: '8098018239'),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenPadding * 2),
                ],
              ),
            ),
    );
  }
}
