import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DeliveryPerson {
  final String? id;
  final String? name;
  final String? phone;

  DeliveryPerson({
    @required this.id,
    @required this.name,
    @required this.phone,
  });
}

class DeliveryPersons with ChangeNotifier {
  List<DeliveryPerson> _items = [];

  List<DeliveryPerson> get items {
    return [..._items];
  }

  bool _listFetched = false;
  bool get listFetched => _listFetched;

  final CollectionReference _fireStore =
      FirebaseFirestore.instance.collection('DeliveryUsers');

  Future<void> fetchItems() async {
    try {
      QuerySnapshot querySnap = await _fireStore.get();
      List<DeliveryPerson> loadedItems = [];

      querySnap.docs.forEach((doc) {
        final data = doc.data() as Map;

        loadedItems.add(
          DeliveryPerson(
            id: data['id'],
            name: data['name'],
            phone: data['phone'],
          ),
        );
      });

      _items = loadedItems;
      _listFetched = true;

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addDeliveryPartner(String name, String phone) async {
    try {
      final id = _fireStore.doc().id;

      await _fireStore.doc(id).set({
        'name': name,
        'phone': phone,
        'id': id,
      }).then((_) {
        _items.insert(
            0,
            DeliveryPerson(
              id: id,
              name: name,
              phone: phone,
            ));

        notifyListeners();
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteDeliveryPartner(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('DeliveryUsers')
          .doc(id)
          .delete()
          .then((_) {
        _items.removeWhere((element) => element.id == id);

        notifyListeners();
      });
    } catch (e) {
      rethrow;
    }
  }
}
