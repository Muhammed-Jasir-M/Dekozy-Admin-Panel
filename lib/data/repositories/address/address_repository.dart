import 'package:aura_kart_admin_panel/data/repositories/authentication/authentication_repository.dart';
import 'package:aura_kart_admin_panel/features/shop/models/address_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<AddressModel>> fecthUserAddresses(String userId) async {
    try {
      // wuery firestore collection to get user address
      final result = await _db.collection('Users').doc(userId).collection('Addresses').get();
      // convert firestore document snapshots to addressodel obkjetcs
      return result.docs.map((documentSnapshot) =>AddressModel.fromDocumentSnapshot(documentSnapshot)).toList();
    } catch (e) {
      throw 'Something went wrong while fetching Address Information.Try again later';
    }
  }

  /// Clear the "Selected" field for all addresses
  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      await _db.collection('Users').doc(userId).collection('Addresses').doc(addressId).update({'SelectedAddress': selected});
    } catch (e) {
      throw 'Unable to update your address selection.Try again later';
    }
  }

  /// Store new User order
  Future<String> addAddress(AddressModel address) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;

      final currentAddress = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .add(address.toJson());

      return currentAddress.id;
    } catch (e) {
      throw 'Something went wrong while saving address Information. Try again Later';
    }
  }
}
