class ReferModel {
  final String theirName;
  final String theirEmail;
  final String theirPhone;
  final String theirAddress1;
  final String theirAddress2;
  final String theirCountry;
  final String theirCity;
  final String theirState;
  final String theirZipCode;
  final List<String> theirUtilityBill;
  final String theirNotes;
  final String dateOfConsultation;
  final String timeOfConsultation;
  final String areTheyHomeOwner;
  final String referredByFirstName;
  final String referredByLastName;
  final String referredByPhone;
  final String referralId;
  final String status;
  final String userId;

  ReferModel({
    required this.theirName,
    required this.theirEmail,
    required this.theirPhone,
    required this.theirAddress1,
    this.theirAddress2 = '',
    required this.theirCountry,
    required this.theirCity,
    required this.theirState,
    required this.theirZipCode,
    required this.theirUtilityBill,
    required this.theirNotes,
    required this.dateOfConsultation,
    required this.timeOfConsultation,
    this.areTheyHomeOwner = '',
    required this.referredByFirstName,
    required this.referredByLastName,
    required this.referredByPhone,
    this.referralId = '',
    this.status = 'Pending',
    required this.userId,
  });

  factory ReferModel.fromJson(Map<String, dynamic> json) {
    return ReferModel(
      theirName: json['theirName'],
      theirEmail: json['theirEmail'],
      theirPhone: json['theirPhone'],
      theirAddress1: json['theirAddress1'],
      theirAddress2: json['theirAddress2'],
      theirCountry: json['theirCountry'],
      theirCity: json['theirCity'],
      theirState: json['theirState'],
      theirZipCode: json['theirZipCode'],
      theirNotes: json['theirNotes'],
      dateOfConsultation: json['dateOfConsultation'],
      timeOfConsultation: json['timeOfConsultation'],
      areTheyHomeOwner: json['areTheyHomeOwner'],
      referredByFirstName: json['referredByFirstName'],
      referredByLastName: json['referredByLastName'],
      referredByPhone: json['referredByPhone'],
      referralId: json['referralId'],
      status: json['status'],
      userId: json['userId'],
      theirUtilityBill: List<String>.from(json['theirUtilityBill']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'theirName': theirName,
      'theirEmail': theirEmail,
      'theirPhone': theirPhone,
      'theirAddress1': theirAddress1,
      'theirAddress2': theirAddress2,
      'theirCountry': theirCountry,
      'theirCity': theirCity,
      'theirState': theirState,
      'theirZipCode': theirZipCode,
      'theirNotes': theirNotes,
      'dateOfConsultation': dateOfConsultation,
      'timeOfConsultation': timeOfConsultation,
      'areTheyHomeOwner': areTheyHomeOwner,
      'referredByFirstName': referredByFirstName,
      'referredByLastName': referredByLastName,
      'referredByPhone': referredByPhone,
      'referralId': referralId,
      'status': status,
      'userId': userId,
      'theirUtilityBill': theirUtilityBill,
    };
  }
}
