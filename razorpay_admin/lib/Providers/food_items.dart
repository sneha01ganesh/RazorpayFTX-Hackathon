import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:razorpay_admin/Models/food_model.dart';

class FoodItems with ChangeNotifier {
  List<FoodModel> _items = [
    FoodModel(
      id: 'sushi',
      title: 'Sushi',
      price: 270,
      combo: false,
      type: 'Lunch',
      availability: 10,
      description:
          'Fuji Sushi, Monsieur Sushi, Meat Ball Sushi, Kayangan Sushi - 5 Pcs each. Serves three people',
      imageUrl: 'https://wallpaperaccess.com/full/767123.jpg',
    ),
    FoodModel(
      id: 'cutlet',
      title: 'Cutlet',
      price: 30,
      combo: false,
      type: 'Special',
      availability: 50,
      description: '2 Pcs - Cutlet',
      imageUrl:
          'https://www.pixelstalk.net/wp-content/uploads/2016/08/Desktop-Food-HD-Wallpapers-Free-Download.jpg',
    ),
    FoodModel(
      id: 'corn',
      title: 'Corn Cheese Masala',
      price: 70,
      combo: false,
      type: 'Lunch',
      availability: 20,
      description:
          'A bowl of 500ml of Corn Cheese Masala which serves two people.',
      imageUrl:
          'https://images.pexels.com/photos/2679501/pexels-photo-2679501.jpeg',
    ),
    FoodModel(
      id: 'chinese-chick',
      title: 'Chinese Chicken Fry',
      price: 120,
      combo: false,
      type: 'Lunch',
      availability: 10,
      description: 'Chinese Style fry of Chicken with Schezwan Sauce',
      imageUrl: 'https://vistapointe.net/images/chinese-food-wallpaper-10.jpg',
    ),
    FoodModel(
      id: 'grill-chick',
      title: 'Grill Chicken',
      price: 150,
      combo: false,
      type: 'Lunch',
      availability: 10,
      description:
          'Barbecue chicken consists of chicken parts or entire chickens that are barbecued, grilled or smoked.',
      imageUrl:
          'https://img.freepik.com/free-photo/concept-indian-cuisine-baked-chicken-wings-legs-honey-mustard-sauce-serving-dishes-restaurant-black-plate-indian-spices-wooden-table-background-image_127425-18.jpg',
    ),
    FoodModel(
      id: 'chick-biriyani',
      title: 'Chicken Biriyani',
      price: 150,
      combo: false,
      type: 'Lunch',
      availability: 10,
      description: 'South Indian Style Chicken Biriyani',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCWMpeGxyNE1jVjX1UfyOBspCrcSvDu0bq4Q&usqp=CAU',
    ),
    FoodModel(
      id: 'chick-wings',
      title: 'Chicken Wings',
      price: 170,
      combo: false,
      type: 'Lunch',
      availability: 10,
      description:
          'Contains 12 Pcs of Chicken Wings with Sesame Seeds and Sweet Chili Sauce',
      imageUrl:
          'https://media.istockphoto.com/photos/baked-chicken-wings-with-sesame-seeds-and-sweet-chili-sauce-on-white-picture-id835903320?k=20&m=835903320&s=612x612&w=0&h=Wp2m7pcihAU4g7RcVW4Pabex1skrouzJwvWCR1-cGUs=',
    ),
    FoodModel(
      id: 'noodles',
      title: 'Egg Noodles',
      price: 75,
      combo: false,
      type: 'Breakfast',
      availability: 10,
      description: 'Steamed Noodles with Boiled Egg. Serves one',
      imageUrl:
          'https://griffithfoods.com/ime/wp-content/uploads/sites/6/2020/04/Group-4@2x-600x408.png',
    ),
    FoodModel(
      id: 'mutton-soup',
      title: 'Mutton Stew',
      price: 160,
      combo: false,
      type: 'Dinner',
      availability: 10,
      description: '150 ml of Mutton Style - Russian Style. Serve for one',
      imageUrl:
          'https://w0.peakpx.com/wallpaper/33/115/HD-wallpaper-russian-food-russian-soup-meat-food.jpg',
    ),
    FoodModel(
      id: 'pot',
      title: 'Pan Fried Potato',
      price: 80,
      combo: false,
      type: 'Dinner',
      availability: 10,
      description: 'One Plate of Pan Fried Potato',
      imageUrl:
          'https://www.kanbrik.com/wp-content/uploads/2020/01/what-is-a-moroccan-tagine-780x470.jpg',
    ),
    FoodModel(
      id: 'kulcha',
      title: 'Stuffed Kulcha',
      price: 75,
      combo: false,
      type: 'Dinner',
      availability: 10,
      description: 'Kulcha stuffed with Indian Masalas',
      imageUrl: 'https://wallpaperaccess.com/full/767086.jpg',
    ),
    FoodModel(
      id: 'mutt-biri',
      title: 'Mutton Biriyani',
      price: 250,
      combo: false,
      type: 'Lunch',
      availability: 10,
      description:
          'One bowl of Mutton Biriyani served along with Raita and Brinjal curry',
      imageUrl: 'https://wallpaperaccess.com/thumb/4859238.jpg',
    ),
    FoodModel(
      id: 'chick-tand-biri',
      title: 'Tandoori Chicken Biriyani',
      price: 185,
      combo: false,
      type: 'Lunch',
      availability: 10,
      description: 'A bowl of Dum Biriyani with Tandoori Chicken',
      imageUrl:
          'https://res.cloudinary.com/swiggy/image/upload/f_auto,q_auto,fl_lossy/thczxs9jkhbdqzufhllw',
    ),
    FoodModel(
      id: 'muffin',
      title: 'Muffin',
      price: 125,
      combo: false,
      type: 'Special',
      availability: 10,
      description: '7 Pcs of Muffin with mixed flavors',
      imageUrl:
          'https://media.istockphoto.com/photos/mini-chocolate-muffins-picture-id539085530?k=20&m=539085530&s=612x612&w=0&h=u5zJTnZHzHYv00QJjEFcHkTt-8HTrtP53UkR0zZ3UsE=',
    ),
    FoodModel(
      id: 'brfst-combo',
      title: 'Breakfast Combo',
      price: 250,
      combo: true,
      type: 'Breakfast',
      availability: 10,
      description:
          'A combo of 2 Half Boil Eggs, 2 Bread, a cup of Fruit Salad, a piece of Beef Streaks and two strips of Bacon',
      imageUrl:
          'https://media-cdn.tripadvisor.com/media/photo-s/17/57/7d/17/2-egg-breakfast.jpg',
      comboItems: [
        FoodModel(
          id: 'halfboil',
          title: 'Half Boiled Egg',
          price: 30,
          combo: false,
          type: 'Breakfast',
          availability: 10,
          description: '',
          imageUrl: '',
        ),
        FoodModel(
          id: 'bread',
          title: 'Bread',
          price: 20,
          combo: false,
          type: 'Breakfast',
          availability: 10,
          description: '2 Pcs of Bread made with Maida Flour',
          imageUrl: '',
        ),
        FoodModel(
          id: 'fruit',
          title: 'Fruit Salad',
          price: 40,
          combo: false,
          type: 'Breakfast',
          availability: 10,
          description: '',
          imageUrl: '',
        ),
        FoodModel(
          id: 'beef',
          title: 'Beef Steak',
          price: 60,
          combo: false,
          type: 'Breakfast',
          availability: 10,
          description: '',
          imageUrl: '',
        ),
        FoodModel(
          id: 'Bacon Strips',
          title: 'Bacon Strips',
          price: 50,
          combo: false,
          type: 'Breakfast',
          availability: 10,
          description: 'Barbequed Strips of Bacon - 2 Pcs',
          imageUrl: '',
        ),
      ],
    ),
    FoodModel(
      id: 'pancake',
      title: 'Pancake',
      price: 40,
      combo: false,
      type: 'Breakfast',
      availability: 10,
      description: 'Four Pcs of pancake with honey',
      imageUrl: 'https://vistapointe.net/images/breakfast-wallpaper-19.jpg',
    ),
    FoodModel(
      id: 'cornflake',
      title: 'Corn Flakes',
      price: 60,
      combo: false,
      type: 'Breakfast',
      availability: 10,
      description: 'A bowl of Corn Flakes',
      imageUrl:
          'https://www.vegrecipesofindia.com/wp-content/uploads/2014/10/corn-flakes-chivda-recipe-1.jpg',
    ),
  ];

  List<FoodModel> get items {
    return [..._items];
  }

  List<bool> _openClose = [];

  List<bool> get openClose {
    return [..._openClose];
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

  Future<void> fetchOpenClose() async {
    try {
      List<bool> fetchedList = [];

      DocumentSnapshot docSnap = await FirebaseFirestore.instance
          .collection('Extras')
          .doc('OpenClose')
          .get();

      fetchedList.add(docSnap.get('breakfast'));
      fetchedList.add(docSnap.get('lunch'));
      fetchedList.add(docSnap.get('dinner'));

      _openClose = fetchedList;

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchItems() async {
    try {
      await fetchOpenClose();

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
      _openClose[ind] = val;

      notifyListeners();
    }).catchError((e) {
      throw e;
    });
  }
}
