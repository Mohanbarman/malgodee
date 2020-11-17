import 'package:url_launcher/url_launcher.dart';

makeCall({String number}) async {
  String numberFormat = 'tel:$number';

  if (await canLaunch(numberFormat)) {
    await launch(numberFormat);
  } else {
    throw 'could not launch $numberFormat';
  }
}
