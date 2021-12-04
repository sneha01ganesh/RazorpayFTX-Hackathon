import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_admin/Models/order_item.dart';
import 'package:razorpay_admin/Helpers/global.dart' as global;

class DeliveryOrders with ChangeNotifier {
  List<OrderItem> _items = [
    OrderItem(
      id: '1',
      name: 'Saran',
      address: 'No 38 A, Pillaiyar Koil Street, Chennai',
      phone: '9876543210',
      status: 'Confirmed',
      requestStatus: 'Confirmed',
      dateTime: Timestamp.fromDate(DateTime(2021, 12, 04, 08, 20)),
      deliveryCharges: 20,
      totalBillAmount: 240,
      paymentStatus: null,
      paymentType: null,
      foodDetails: [
        {'id': '123', 'price': 120, 'quantity': 3, 'title': 'Idly'},
        {'id': '123', 'price': 100, 'quantity': 2, 'title': 'Dosa'},
      ],
    ),
    OrderItem(
      id: '2',
      name: 'Saran',
      address: 'AMC Enclave, No. 6, Third Cross Street, Sterling Road',
      phone: '9876543210',
      status: 'Delivered',
      dateTime: Timestamp.fromDate(DateTime(2021, 12, 03, 20, 23)),
      deliveryCharges: 20,
      totalBillAmount: 320,
      paymentStatus: null,
      paymentType: null,
      foodDetails: [
        {'id': '123', 'price': 300, 'quantity': 5, 'title': 'Pancake'},
      ],
    ),
    OrderItem(
      id: '3',
      name: 'Saran',
      address: 'AMC Enclave, No. 6, Third Cross Street, Sterling Road',
      phone: '9876543210',
      status: 'Delivered',
      dateTime: Timestamp.fromDate(DateTime(2021, 12, 03, 13, 12)),
      deliveryCharges: 20,
      totalBillAmount: 540,
      paymentStatus: null,
      paymentType: null,
      foodDetails: [
        {'id': '123', 'price': 180, 'quantity': 2, 'title': 'Chicken Biriyani'},
        {'id': '123', 'price': 120, 'quantity': 1, 'title': 'Grill Chicken'},
        {'id': '123', 'price': 120, 'quantity': 1, 'title': 'BBQ Chicken'},
        {'id': '123', 'price': 50, 'quantity': 1, 'title': 'Curd Rice'},
      ],
    ),
  ];

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
