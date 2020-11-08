import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:ShoppingApp/bloc/phone_number_field_bloc.dart';
import 'package:ShoppingApp/components/custom_text_field.dart';
import 'package:flutter/services.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/components/underlined_text.dart';
import 'package:ShoppingApp/components/rounded_icon_container.dart';

class ContactUsSection extends StatelessWidget {
  final String _callIcon = 'assets/images/call-icon.png';
  final String _waIcon = 'assets/images/wa-icon.png';

  final PhoneNumberFieldBloc _callingNumberBloc = PhoneNumberFieldBloc();
  final PhoneNumberFieldBloc _wpNumberBloc = PhoneNumberFieldBloc();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        initialData: adminStreamController.initialData,
        stream: adminStreamController.authStatusStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == UserAuth.unauthorized) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UnderlinedText('Contact us'),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedIconContainer(title: 'Call', imagePath: _callIcon),
                    SizedBox(width: 30),
                    RoundedIconContainer(title: 'Chat', imagePath: _waIcon),
                  ],
                ),
                SizedBox(height: 30),
              ],
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: ScreenPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UnderlinedText('Edit contact number'),
                  SizedBox(height: ScreenPadding),
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    shadow: textInputShadow,
                    textBloc: _callingNumberBloc,
                    title: 'Calling number',
                  ),
                  SizedBox(height: ScreenPadding),
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    shadow: textInputShadow,
                    textBloc: _wpNumberBloc,
                    title: 'Whatsapp number',
                  ),
                  SizedBox(height: ScreenPadding * 2),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
