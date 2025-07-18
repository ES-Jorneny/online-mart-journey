class UserModel {
  final String uid;
  final String username;
  final String email;
  final String phone;
  final String userImgUrl;
  final String userDeviceToken;
  final String country;
  final String userAddress;
  final String street;
  final bool isAdmin;
  final bool isActive;
  final dynamic createdOn;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.phone,
    required this.userImgUrl,
    required this.userDeviceToken,
    required this.country,
    required this.userAddress,
    required this.street,
    required this.isAdmin,
    required this.isActive,
    required this.createdOn,
  });

  // ✅ Convert model to JSON (for Firestore/REST API)
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'phone': phone,
      'userImgUrl': userImgUrl,
      'userDeviceToken': userDeviceToken,
      'country': country,
      'userAddress': userAddress,
      'street': street,
      'isAdmin': isAdmin,
      'isActive': isActive,
      'createdOn': createdOn,
    };
  }

  // ✅ Create model from JSON (e.g., from Firestore document)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      userImgUrl: json['userImgUrl'] ?? '',
      userDeviceToken: json['userDeviceToken'] ?? '',
      country: json['country'] ?? '',
      userAddress: json['userAddress'] ?? '',
      street: json['street'] ?? '',
      isAdmin: json['isAdmin'] ?? false,
      isActive: json['isActive'] ?? true,
      createdOn: json['createdOn'], // keep dynamic (Timestamp, DateTime, etc.)
    );
  }
}
