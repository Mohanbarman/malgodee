import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:ShoppingApp/bloc/phone_number_field_bloc.dart';
import 'package:ShoppingApp/utils/make_call.dart';
import 'package:ShoppingApp/utils/wp_chat.dart';
import 'package:ShoppingApp/widgets/custom_text_field.dart';
import 'package:ShoppingApp/services/firestore_api.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/widgets/underlined_text.dart';
import 'package:ShoppingApp/widgets/rounded_icon_container.dart';

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
          if (!snapshot.hasData) return SizedBox();
          if (snapshot.data == UserAuth.unauthorized) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UnderlinedText('Contact us'),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder(
                        stream: FirebaseStorageApi.streamOfCollection(
                          collection: 'calling_number',
                        ),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return CircularProgressIndicator();
                          return RoundedIconContainer(
                            title: 'Call',
                            imagePath: _callIcon,
                            padding: 12,
                            onTap: () => makeCall(
                              number: snapshot.data.docs[0]['phone_number'],
                            ),
                          );
                        }),
                    SizedBox(width: 30),
                    StreamBuilder(
                      stream: FirebaseStorageApi.streamOfCollection(
                        collection: 'whatsapp_number',
                      ),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return SizedBox();
                        return RoundedIconContainer(
                          title: 'Chat',
                          imagePath: _waIcon,
                          padding: 12,
                          onTap: () {
                            print('called');
                            openWhatsapp(
                              number: snapshot.data.docs[0]['phone_number'],
                            );
                          },
                        );
                      },
                    ),
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
                    collectionName: 'calling_number',
                    collectionStream: FirebaseStorageApi.streamOfCollection(
                      collection: 'calling_number',
                    ),
                  ),
                  SizedBox(height: ScreenPadding),
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    shadow: textInputShadow,
                    textBloc: _wpNumberBloc,
                    title: 'Whatsapp number',
                    collectionName: 'whatsapp_number',
                    collectionStream: FirebaseStorageApi.streamOfCollection(
                      collection: 'whatsapp_number',
                    ),
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
