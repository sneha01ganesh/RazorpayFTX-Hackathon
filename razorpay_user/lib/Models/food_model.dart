import 'package:flutter/foundation.dart';

class FoodModel {
  String? id;
  String? title;
  String? description;
  int? price;
  int? availability;
  String? imageUrl;
  String? type;
  bool? combo;
  List<FoodModel>? comboItems;
  List? comboDocs;

  FoodModel({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.availability,
    @required this.imageUrl,
    @required this.type,
    this.combo,
    this.comboItems,
    this.comboDocs,
  });

  FoodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    availability = json['availability'];
    imageUrl = json['imageUrl'];
    type = json['type'];
    combo = json['combo'];
    comboItems = json['comboItems'];
    comboDocs = json['comboDocs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['availability'] = availability;
    data['imageUrl'] = imageUrl;
    data['type'] = type;
    data['combo'] = combo;
    data['comboItems'] = comboItems;
    data['comboDocs'] = comboDocs;
    return data;
  }
}
