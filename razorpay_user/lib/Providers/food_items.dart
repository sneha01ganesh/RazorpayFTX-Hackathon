import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:razorpay_user/Models/food_model.dart';

class FoodItems with ChangeNotifier {
  List<FoodModel> _items = [
    FoodModel(
      id: '1',
      title: 'Biriyani',
      price: 150,
      combo: false,
      type: 'Breakfast',
      availability: 10,
      description: 'Chicken Biriyani - South Indian Style',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCWMpeGxyNE1jVjX1UfyOBspCrcSvDu0bq4Q&usqp=CAU',
    ),
    FoodModel(
      id: '2',
      title: 'Rice',
      price: 50,
      combo: false,
      type: 'Lunch',
      availability: 10,
      description: 'Chicken Biriyani - South Indian Style',
      imageUrl:
          'https://www.pixelstalk.net/wp-content/uploads/2016/08/Desktop-Food-HD-Wallpapers-Free-Download.jpg',
    ),
    FoodModel(
      id: '3',
      title: 'Food',
      price: 10,
      combo: false,
      type: 'Lunch',
      availability: 10,
      description: 'Chicken Biriyani - South Indian Style',
      imageUrl:
          'https://images.pexels.com/photos/2679501/pexels-photo-2679501.jpeg',
    ),
    FoodModel(
      id: '3',
      title: 'Food',
      price: 10,
      combo: false,
      type: 'Lunch',
      availability: 10,
      description: 'Chicken Biriyani - South Indian Style',
      imageUrl:
          'https://media.istockphoto.com/photos/south-indian-food-picture-id481149282?k=20&m=481149282&s=612x612&w=0&h=GIQNHyiT8h6iBvPtAEnb61R8xVIpXvSmKbFsssFGryU=',
    ),
    FoodModel(
      id: '3',
      title: 'Food',
      price: 10,
      combo: false,
      type: 'Lunch',
      availability: 10,
      description: 'Chicken Biriyani - South Indian Style',
      imageUrl: 'https://vistapointe.net/images/chinese-food-wallpaper-10.jpg',
    ),
    FoodModel(
      id: '3',
      title: 'Food',
      price: 10,
      combo: false,
      type: 'Lunch',
      availability: 10,
      description: 'Chicken Biriyani - South Indian Style',
      imageUrl:
          'https://img.freepik.com/free-photo/concept-indian-cuisine-baked-chicken-wings-legs-honey-mustard-sauce-serving-dishes-restaurant-black-plate-indian-spices-wooden-table-background-image_127425-18.jpg',
    ),
    FoodModel(
      id: '3',
      title: 'Food',
      price: 10,
      combo: false,
      type: 'Lunch',
      availability: 10,
      description: 'Chicken Biriyani - South Indian Style',
      imageUrl:
          'https://media.istockphoto.com/photos/baked-chicken-wings-with-sesame-seeds-and-sweet-chili-sauce-on-white-picture-id835903320?k=20&m=835903320&s=612x612&w=0&h=Wp2m7pcihAU4g7RcVW4Pabex1skrouzJwvWCR1-cGUs=',
    ),
    FoodModel(
      id: '3',
      title: 'Food',
      price: 10,
      combo: false,
      type: 'Lunch',
      availability: 10,
      description: 'Chicken Biriyani - South Indian Style',
      imageUrl:
          'https://griffithfoods.com/ime/wp-content/uploads/sites/6/2020/04/Group-4@2x-600x408.png',
    ),
    FoodModel(
      id: '3',
      title: 'Food',
      price: 10,
      combo: false,
      type: 'Lunch',
      availability: 10,
      description: 'Chicken Biriyani - South Indian Style',
      imageUrl:
          'https://w0.peakpx.com/wallpaper/33/115/HD-wallpaper-russian-food-russian-soup-meat-food.jpg',
    ),
    FoodModel(
      id: '3',
      title: 'Food',
      price: 10,
      combo: false,
      type: 'Lunch',
      availability: 10,
      description: 'Chicken Biriyani - South Indian Style',
      imageUrl:
          'https://www.kanbrik.com/wp-content/uploads/2020/01/what-is-a-moroccan-tagine-780x470.jpg',
    ),
    FoodModel(
      id: '3',
      title: 'Food',
      price: 10,
      combo: false,
      type: 'Lunch',
      availability: 10,
      description: 'Chicken Biriyani - South Indian Style',
      imageUrl: 'https://wallpaperaccess.com/full/767086.jpg',
    ),
    FoodModel(
      id: '3',
      title: 'Food',
      price: 10,
      combo: false,
      type: 'Lunch',
      availability: 10,
      description: 'Chicken Biriyani - South Indian Style',
      imageUrl: 'https://wallpaperaccess.com/full/767123.jpg',
    ),
    FoodModel(
      id: '3',
      title: 'Food',
      price: 10,
      combo: false,
      type: 'Lunch',
      availability: 10,
      description: 'Chicken Biriyani - South Indian Style',
      imageUrl: 'https://wallpaperaccess.com/thumb/4859238.jpg',
    ),
    FoodModel(
      id: '3',
      title: 'Food',
      price: 10,
      combo: false,
      type: 'Lunch',
      availability: 10,
      description: 'Chicken Biriyani - South Indian Style',
      imageUrl:
          'https://res.cloudinary.com/swiggy/image/upload/f_auto,q_auto,fl_lossy/thczxs9jkhbdqzufhllw',
    ),
    FoodModel(
      id: '3',
      title: 'Food',
      price: 10,
      combo: false,
      type: 'Lunch',
      availability: 10,
      description: 'Chicken Biriyani - South Indian Style',
      imageUrl:
          'https://media.istockphoto.com/photos/mini-chocolate-muffins-picture-id539085530?k=20&m=539085530&s=612x612&w=0&h=u5zJTnZHzHYv00QJjEFcHkTt-8HTrtP53UkR0zZ3UsE=',
    ),
    FoodModel(
      id: '3',
      title: 'Food',
      price: 10,
      combo: false,
      type: 'Lunch',
      availability: 10,
      description: 'Chicken Biriyani - South Indian Style',
      imageUrl:
          'https://media-cdn.tripadvisor.com/media/photo-s/17/57/7d/17/2-egg-breakfast.jpg',
    ),
    FoodModel(
      id: '3',
      title: 'Food',
      price: 10,
      combo: false,
      type: 'Lunch',
      availability: 10,
      description: 'Chicken Biriyani - South Indian Style',
      imageUrl:
          'https://res.cloudinary.com/hamstech/images/v1632121563/Hamstech%20App/Title-Image_80464696efa86/Title-Image_80464696efa86.jpg',
    ),
    FoodModel(
      id: '3',
      title: 'Food',
      price: 10,
      combo: false,
      type: 'Lunch',
      availability: 10,
      description: 'Chicken Biriyani - South Indian Style',
      imageUrl: 'https://vistapointe.net/images/breakfast-wallpaper-19.jpg',
    ),
    FoodModel(
      id: '3',
      title: 'Food',
      price: 10,
      combo: false,
      type: 'Lunch',
      availability: 10,
      description: 'Chicken Biriyani - South Indian Style',
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

  bool verifyFood(String id) {
    if (_items.indexWhere((order) => order.id == id) >= 0) {
      return true;
    } else {
      return false;
    }
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
      // print(e);
      rethrow;
    }
  }

  Future<void> fetchItems() async {
    try {
      await fetchOpenClose();

      QuerySnapshot querySnap = await _foodStore.get();
      final List<FoodModel> loadedItems = [];
      for (var doc in querySnap.docs) {
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
      }

      for (var food in loadedItems) {
        if (food.combo == true) {
          List<FoodModel> _comboItems = [];
          for (int i = 0; i < food.comboDocs!.length; i++) {
            final _ind = loadedItems.indexWhere(
                (element) => element.id == food.comboDocs![i].toString());

            if (_ind > -1) {
              _comboItems.add(loadedItems[_ind]);
            }
          }
          food.comboItems = _comboItems;
        }

        if (food.comboItems!.isNotEmpty) {
          food.combo = false;
        }
      }

      _items = loadedItems;
      _listFetched = true;

      notifyListeners();
    } catch (error) {
      // print(error);
      rethrow;
    }
  }

  void editItems(String id, int quantity) {
    final food = findById(id);

    food.availability = food.availability! - quantity;

    notifyListeners();
  }
}
