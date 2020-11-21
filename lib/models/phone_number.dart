class PhoneNumberModel {
  String id;
  String phone_number;

  PhoneNumberModel.fromMap(Map data)
      : phone_number = data['phone_number'],
        id = data['id'];

  PhoneNumberModel({this.phone_number, this.id});

  toJson() => Map<String, dynamic>.from({
        'phone_number': phone_number,
        'id': id,
      });
}
