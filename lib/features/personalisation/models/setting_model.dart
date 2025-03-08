import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsModel {
  final String? id;
  double taxRate;
  double shippingCost;
  double? freeShippingThreshold;
  String appName;
  String appLogo;

  /// Constructor for SettingsModel
  SettingsModel({
    this.id,
    this.taxRate = 0.0,
    this.shippingCost = 0.0,
    this.freeShippingThreshold,
    this.appName = '',
    this.appLogo = '',
  });

  /// Convert model to json structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'taxrate': taxRate,
      'shippingCost': shippingCost,
      'freeShippingThreshold': freeShippingThreshold,
      'appLogo': appLogo,
      'appName': appName,
    };
  }

  /// factgory model to create a  settingmodel from firebase document snapshot
  factory SettingsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();

    if (data != null) {
      return SettingsModel(
        id: document.id,
        taxRate: (data['taxRate'] as num?)?.toDouble() ?? 0.0,
        shippingCost: (data['shippingCost'] as num?)?.toDouble() ?? 0.0,
        freeShippingThreshold:
            (data['freeShippingThreshold'] as num?)?.toDouble() ?? 0.0,
        appName: data.containsKey('appName') ? data['appName'] ?? '' : '',
        appLogo: data.containsKey('appLogo') ? data['appLogo'] ?? '' : '',
      );
    } else {
      return SettingsModel();
    }
  }
}
