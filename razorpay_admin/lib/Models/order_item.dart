import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class OrderItem {
  String? id;
  String? name;
  String? address;
  String? phone;
  String? status;
  Timestamp? dateTime;
  int? deliveryCharges;
  int? totalBillAmount;
  String? paymentStatus;
  String? paymentType;
  String? paymentId;
  String? uid;
  String? requestStatus;
  String? deliveryPartner;
  String? deliveryPartnerId;
  String? deliveryPartnerPhone;
  GeoPoint? latLng;
  List? foodDetails;

  OrderItem({
    @required this.id,
    @required this.name,
    @required this.address,
    @required this.phone,
    @required this.status,
    @required this.dateTime,
    @required this.deliveryCharges,
    @required this.totalBillAmount,
    @required this.paymentStatus,
    @required this.paymentType,
    @required this.foodDetails,
    this.paymentId,
    this.uid,
    this.requestStatus,
    this.deliveryPartner,
    this.deliveryPartnerId,
    this.deliveryPartnerPhone,
    this.latLng,
  });

  OrderItem.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    status = json['status'];
    dateTime = json['dateTime'];
    deliveryCharges = json['deliveryCharges'];
    totalBillAmount = json['totalBillAmount'];
    paymentStatus = json['paymentStatus'];
    paymentType = json['paymentType'];
    paymentId = json['paymentId'];
    requestStatus = json['requestStatus'];
    uid = json['uid'];
    deliveryPartner = json['deliveryPartner'];
    deliveryPartnerId = json['deliveryPartnerId'];
    deliveryPartnerPhone = json['deliveryPartnerPhone'];
    latLng = json['latLng'];
    foodDetails = json['foodDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['phone'] = phone;
    data['status'] = status;
    data['dateTime'] = dateTime;
    data['deliveryCharges'] = deliveryCharges;
    data['totalBillAmount'] = totalBillAmount;
    data['paymentStatus'] = paymentStatus;
    data['paymentType'] = paymentType;
    data['requestStatus'] = requestStatus;
    data['paymentId'] = paymentId;
    data['uid'] = uid;
    data['deliveryPartner'] = deliveryPartner;
    data['deliveryPartnerId'] = deliveryPartnerId;
    data['deliveryPartnerPhone'] = deliveryPartnerPhone;
    data['latLng'] = latLng;
    data['foodDetails'] = foodDetails;
    return data;
  }
}
