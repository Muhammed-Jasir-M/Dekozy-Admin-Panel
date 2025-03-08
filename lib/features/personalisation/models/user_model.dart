import 'package:aura_kart_admin_panel/features/personalisation/models/address_model.dart';
import 'package:aura_kart_admin_panel/features/shop/models/order_model.dart';
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
  List<OrderModel>? orders;
  List<AddressModel>? addresses;

  // Constructor
  UserModel({
    this.id,
    this.firstName = '',
    this.lastName = '',
    this.username = '',
    required this.email,
    this.phoneNumber = '',
    this.profilePicture = '',
    this.role = AppRole.user,
    this.createdAt,
    this.updatedAt,
  });

  // Helper Methods
  String get fullName => '$firstName $lastName';

  String get formattedDate => AFormatter.formatDate(createdAt);

  String get formattedUpdatedAtDate => AFormatter.formatDate(updatedAt);

  String get formattedPhoneNo => AFormatter.formatPhoneNumber(phoneNumber);

  // Static function to split full name into first and last name.
  static List<String> nameParts(String fullName) => fullName.split(" ");

  // Static function to generate username from fullname.
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "aura_$camelCaseUsername";
    return usernameWithPrefix;
  }

  // Static function to create an empty user model.
  static UserModel empty() => UserModel(
        // id: '',
        // firstName: '',
        // lastName: '',
        // phoneNumber: '',
        // profilePicture: '',
        // username: '',
        email: '',
        // role: AppRole.user,
      );

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
      'UpdatedAt': updatedAt ?? DateTime.now(),
    };
  }

  // Factory method to create a UserModel form a Firebase document snapshot.
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return UserModel(
        id: document.id,
        firstName: data.containsKey('FirstName') ? data['FirstName'] ?? '' : '',
        lastName: data.containsKey('LastName') ? data['LastName'] ?? '' : '',
        username: data.containsKey('UserName') ? data['UserName'] ?? '' : '',
        email: data.containsKey('Email') ? data['Email'] ?? '' : '',
        phoneNumber:
            data.containsKey('PhoneNumber') ? data['PhoneNumber'] ?? '' : '',
        profilePicture: data.containsKey('ProfilePicture')
            ? data['ProfilePicture'] ?? ''
            : '',
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
      return UserModel.empty();
    }
  }
}
