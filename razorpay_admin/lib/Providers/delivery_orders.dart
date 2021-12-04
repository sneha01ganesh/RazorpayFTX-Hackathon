import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_admin/Models/order_item.dart';
import 'package:razorpay_admin/Helpers/global.dart' as global;

class DeliveryOrders with ChangeNotifier {
  List<OrderItem> _items = [];

  List<OrderItem> get items {
    return [..._items];
  }

  OrderItem findById(String id) {
    return _items.firstWhere((order) => order.id == id);
  }

  bool _listFetched = false;
  bool get listFetched => _listFetched;

  final CollectionReference _orderStore =
      FirebaseFirestore.instance.collection('Orders');

  Future<void> fetchOrders() async {
    try {
      QuerySnapshot querySnap = await _orderStore
          .where('deliveryPartnerId', isEqualTo: global.deliveryId)
          .get();
      final List<OrderItem> loadedItems = [];

      querySnap.docs.forEach((doc) {
        final data = doc.data() as Map;

        OrderItem item = OrderItem.fromJson(data);

        loadedItems.add(item);
      });

      _items = loadedItems;
      _listFetched = true;

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> orderDelivered(String id) async {
    try {
      final order = findById(id);

      order.status = 'Delivered';
      order.paymentStatus = 'Paid';
      notifyListeners();

      // await _orderStore.doc(id).update({
      //   'status': 'Delivered',
      //   'paymentStatus': 'Paid',
      // }).then((_) {
      //   order.status = 'Delivered';
      //   order.paymentStatus = 'Paid';

      //   notifyListeners();
      // });
    } catch (e) {
      rethrow;
    }
  }
}
