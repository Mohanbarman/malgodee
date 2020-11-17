import 'package:url_launcher/url_launcher.dart';

openWhatsapp({String number}) async {
  String numberUrl = 'https://wa.me/91$number';

  if (await canLaunch(numberUrl)) {
    await launch(numberUrl);
  } else {
    throw 'Could not launch url $numberUrl';
  }
}
