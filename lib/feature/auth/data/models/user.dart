class UserModel {
  final String id;
  final String email;
  final String firstName, lastName;
  final String phoneNumber;
  final ServiceType serviceType;
  final String howMuch;
  final String refFirstName, refLastName;
  final String message;
  final String userId;

  UserModel({
    this.id = '',
    this.email = '',
    this.firstName = '',
    this.lastName = '',
    this.phoneNumber = '',
    this.serviceType = ServiceType.referring,
    this.howMuch = '',
    this.refFirstName = '',
    this.refLastName = '',
    this.message = '',
    this.userId = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName']  ?? '',
      phoneNumber: json['phoneNumber'] ,
      serviceType: ServiceType.values[json['serviceType']] ,
      howMuch: json['howMuch'],
      refFirstName: json['refFirstName'],
      refLastName: json['refLastName'],
      message: json['message'],
      userId: json['userId'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'serviceType': serviceType.index,
      'howMuch': howMuch,
      'refFirstName': refFirstName,
      'refLastName': refLastName,
      'message': message,
      'userId': userId,
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    ServiceType? serviceType,
    String? howMuch,
    String? refFirstName,
    String? refLastName,
    String? message,
    String? userId,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      serviceType: serviceType ?? this.serviceType,
      howMuch: howMuch ?? this.howMuch,
      refFirstName: refFirstName ?? this.refFirstName,
      refLastName: refLastName ?? this.refLastName,
      message: message ?? this.message,
      userId: userId ?? this.userId,
    );
  }
}

enum ServiceType {
  referring,
  selling,
  buying,
}
