import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/formatters/formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  String firstName;
  String lastName;
  String username;
  String email;
  String phoneNumber;
  String profilePicture;
  AppRole role;
  DateTime? createdAt;
  DateTime? updatedAt;

  // Constructor
  UserModel({
    this.id,
    this.firstName = '',
    this.lastName = '',
    this.phoneNumber = '',
    this.profilePicture = '',
    this.username = '',
    required this.email,
    this.role = AppRole.user,
    this.createdAt,
    this.updatedAt,
  });

  // Helper Methods
  String get fullName => '$firstName $lastName';
  String get formattedDate => AFormatter.formatDate(createdAt);
  String get formattedUpdatedAtDate => AFormatter.formatDate(updatedAt);
  String get formattedPhoneNo => AFormatter.formatPhoneNumber(phoneNumber);

  // Static function to create an empty user model.
  static UserModel empty() => UserModel(email: '');

  // Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'UserName': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'Role': role.name.toString(),
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt = DateTime.now(),
    };
  }

  // Factory method to create a UserModel form a Firebase document snapshot.
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data.containsKey('FirstName') ? data['FirstName'] ?? '' : '',
        lastName: data.containsKey('LastName') ? data['LastName'] ?? '' : '',
        phoneNumber:
            data.containsKey('PhoneNumber') ? data['PhoneNumber'] ?? '' : '',
        profilePicture: data.containsKey('ProfilePicture')
            ? data['ProfilePicture'] ?? ''
            : '',
        username: data.containsKey('UserName') ? data['Username'] ?? '' : '',
        email: data.containsKey('Email') ? data['Email'] ?? '' : '',
        role: data.containsKey('Role')
            ? (data['Role'] ?? AppRole.user) == AppRole.admin.name.toString()
                ? AppRole.admin
                : AppRole.user
            : AppRole.user,
        createdAt: data.containsKey('CreatedAt')
            ? data['CreatedAt']?.toDate() ?? DateTime.now()
            : DateTime.now(),
        updatedAt: data.containsKey('UpdatedAt')
            ? data['UpdatedAt']?.toDate() ?? DateTime.now()
            : DateTime.now(),
      );
    } else {
      return empty();
    }
  }
}
