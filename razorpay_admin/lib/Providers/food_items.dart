import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:razorpay_admin/Models/food_model.dart';

class FoodItems with ChangeNotifier {
  List<FoodModel> _items = [];

  List<FoodModel> get items {
    return [..._items];
  }

  List<FoodModel> get breakfastItems {
    return [..._items.where((food) => food.type == 'Breakfast')];
  }

  List<FoodModel> get lunchItems {
    return [..._items.where((food) => food.type == 'Lunch')];
  }

  List<FoodModel> get dinnerItems {
    return [..._items.where((food) => food.type == 'Dinner')];
  }

  List<FoodModel> get specialItems {
    return [..._items.where((food) => food.type == 'Special')];
  }

  FoodModel findById(String id) {
    return _items.firstWhere((order) => order.id == id);
  }

  bool _listFetched = false;
  bool get listFetched => _listFetched;

  final CollectionReference _foodStore =
      FirebaseFirestore.instance.collection('FoodItems');

  Future<void> fetchItems() async {
    try {
      QuerySnapshot querySnap = await _foodStore.get();
      final List<FoodModel> loadedItems = [];

      querySnap.docs.forEach((doc) {
        final data = doc.data() as Map;

        loadedItems.add(
          FoodModel(
            id: data['id'],
            title: data['title'],
            description: data['description'],
            price: data['price'],
            availability: data['availability'],
            imageUrl: data['imageUrl'],
            type: data['type'],
            combo: data['combo'] ?? false,
            comboDocs: data['comboDocs'],
            comboItems: [],
          ),
        );
      });

      for (var food in loadedItems) {
        if (food.combo == true) {
          List<FoodModel> _comboItems = [];
          for (int i = 0; i < food.comboDocs!.length; i++) {
            final _ind = loadedItems.indexWhere(
                (element) => element.id == food.comboDocs![i].toString());

            if (_ind >= 0) {
              _comboItems.add(loadedItems[_ind]);
            }
          }
          food.comboItems = _comboItems;
        }
      }

      _items = loadedItems;
      _listFetched = true;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void addFood(FoodModel foodModel) async {
    List<String> _docList = [];

    final json = foodModel.toJson();

    if (foodModel.combo == true) {
      for (int i = 0; i < foodModel.comboItems!.length; i++) {
        final _item = foodModel.comboItems![i].toJson();
        final _itemId = foodModel.comboItems![i].id;

        await _foodStore.doc(_itemId).set(_item).then((value) {
          _docList.add(_itemId ?? "");
          _items.add(foodModel.comboItems![i]);
        });
      }

      json['comboItems'] = [];
      json['comboDocs'] = _docList;
    }
    final docId = _foodStore.doc().id;
    json['id'] = docId;

    foodModel.id = docId;

    await _foodStore.doc(docId).set(json).then((value) {
      _items.add(foodModel);

      notifyListeners();
    });
  }

  void updateFood(FoodModel foodModel) async {
    final foodJson = foodModel.toJson();

    if (foodModel.combo == true) {
      foodJson['comboItems'] = [];
    }

    await _foodStore.doc(foodModel.id).update(foodJson).then((_) async {
      final foodIndex = _items.indexWhere((food) => food.id == foodModel.id);

      if (foodIndex >= 0) {
        _items[foodIndex] = foodModel;
      }
    });

    notifyListeners();
  }

  Future<void> deleteFood(String id) async {
    try {
      final food = findById(id);

      await _foodStore.doc(id).delete().then((_) async {
        await FirebaseStorage.instance
            .refFromURL(food.imageUrl ?? "")
            .delete()
            .then((_) {
          _items.removeWhere((foodModel) => foodModel.id == id);

          notifyListeners();
        });
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAllItems(List _itemList) async {
    try {
      _itemList.forEach((element) async {
        final id = element.id;
        final food = findById(id);

        await _foodStore.doc(id).delete().then((_) async {
          await FirebaseStorage.instance
              .refFromURL(food.imageUrl ?? "")
              .delete()
              .then((_) {
            _items.removeWhere((foodModel) => foodModel.id == id);

            notifyListeners();
          });
        });
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> switchOpenClose(String type, bool val) async {
    int ind = 0;
    if (type == 'Breakfast') ind = 0;
    if (type == 'Lunch') ind = 1;
    if (type == 'Dinner') ind = 2;

    await FirebaseFirestore.instance
        .collection('Extras')
        .doc('OpenClose')
        .update({type.toLowerCase(): val}).then((_) {
      notifyListeners();
    }).catchError((e) {
      throw e;
    });
  }
}
