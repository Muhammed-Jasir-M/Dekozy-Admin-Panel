import 'package:cloud_firestore/cloud_firestore.dart';

class SettingModel {
  final String? id;
  double taxRate;
  double shippingCost;
  double? freeShippingThreshold;
  String appName;
  String appLogo;

  // constructor for settingmodel
  SettingModel({
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
      'shippingCost' : shippingCost,
      'freeShippingThreshold' : freeShippingThreshold,
      'appLogo' : appLogo,
      'appName' : appName,
    };
  }

  factory SettingModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() )
  }
}
