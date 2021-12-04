import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_user/Models/order_item.dart';
import 'package:razorpay_user/Providers/cart.dart';
import 'package:razorpay_user/Providers/food_items.dart';
import 'package:razorpay_user/Providers/orders.dart';

class PlaceOrder {
  final CollectionReference _foodStore =
      FirebaseFirestore.instance.collection('FoodItems');

  final CollectionReference _orderStore =
      FirebaseFirestore.instance.collection('Orders');

  Future<bool> placeFood(
    context, {
    String? address,
    int? deliveryCharges,
    String? paymentType,
    String? paymentId,
    GeoPoint? latLng,
  }) async {
    bool uploaded = true;

    final cart = Provider.of<Cart>(context, listen: false);
    final orderProvider = Provider.of<Orders>(context, listen: false);
    final foodItem = Provider.of<FoodItems>(context, listen: false);
    final cartItems = cart.items;

    final List<Map<String, dynamic>> _editedCartDetails = [];

    try {
      cartItems.forEach((key, value) {
        final cartItem = {
          'id': value.id,
          'title': value.title,
          'price': value.price,
          'quantity': value.quantity,
        };
        _editedCartDetails.add(cartItem);
      });

      final id = _orderStore.doc().id;

      final orderItem = OrderItem(
        id: id,
        uid: 'order_id_123',
        name: 'John',
        address: address,
        phone: '9876543210',
        status: 'Order Placed',
        requestStatus: 'Pending',
        dateTime: Timestamp.now(),
        deliveryCharges: deliveryCharges,
        totalBillAmount: cart.totalAmount + 30,
        paymentStatus: paymentType == null ? 'Pending' : 'Paid',
        paymentType: paymentType ?? 'Cash on Delivery',
        paymentId: paymentId,
        latLng: latLng,
        foodDetails: _editedCartDetails,
      );

      uploaded = true;

      // await _orderStore.doc(id).set(orderItem.toJson()).then((__) async {
      //   for (var food in _editedCartDetails) {
      //     await _foodStore.doc(food['id']).update({
      //       'availability':
      //           foodItem.findById(food['id']).availability! - food['quantity'],
      //     }).then((_) {
      //       foodItem.editItems(food['id'], food['quantity']);
      //     });
      //   }

      //   orderProvider.placeNewOrder(orderItem);
      //   cart.clearItems();
      // });
    } catch (error) {
      rethrow;
    }

    return uploaded;
  }
}
