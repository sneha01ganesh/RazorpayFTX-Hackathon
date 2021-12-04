import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminVerification {
  static Future<bool> login(int enteredPin) async {
    // UserCredential auth = await FirebaseAuth.instance.signInAnonymously();

    // CollectionReference _firestore =
    //     FirebaseFirestore.instance.collection('Extras');

    // bool correctPassword;

    try {
      //   DocumentSnapshot docSnap = await _firestore.doc('AdminPasscode').get();

      //   int passcode = docSnap.get('passcode');

      //   if (enteredPin == passcode) {
      //     correctPassword = true;
      //   } else {
      //     correctPassword = false;
      //   }

      //   return correctPassword;
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
