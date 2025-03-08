import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsModel {
  final String? id;
  double taxRate;
  double shippingCost;
  double? freeShippingThreshold;
  String appName;
  String appLogo;

  // constructor for settingmodel
  SettingsModel({
    this.id,
    this.taxRate = 0.0,
    this.shippingCost = 0.0,
    this.freeShippingThreshold,
    this.appName = '',
    this.appLogo = '',
  });

  // convert moddel to sjon structure for string data in firstor
  Map<String, dynamic> toJson() {
    return {
      'taxrate': taxRate,
      'shippingCost': shippingCost,
      'freeShippingThreshold': freeShippingThreshold,
      'appLogo': appLogo,
      'appName': appName,
    };
  }
   
  // factgory model to create a  settingmodel from firebase document snapshot
  factory SettingsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data();
    }
  }
}
