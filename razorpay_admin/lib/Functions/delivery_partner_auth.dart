import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveryPartnerAuth {
  static Future<bool> verifyUser(String phone) async {
    try {
      CollectionReference _firestore =
          FirebaseFirestore.instance.collection('DeliveryUsers');

      QuerySnapshot query =
          await _firestore.where('phone', isEqualTo: phone).get();

      bool user = query.docs.isNotEmpty;

      return user;
    } catch (e) {
      rethrow;
    }
  }
}
