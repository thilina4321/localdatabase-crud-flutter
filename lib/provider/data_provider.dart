import 'package:flutter/cupertino.dart';
import 'package:localdatastorage/helper/db_helper.dart';

class Item {
  String name;
  String age;
  int id;

  Item({this.id, this.name, this.age});
}

class DataProvider with ChangeNotifier {
  List<Item> _items = [];

  List<Item> get items {
    return [..._items];
  }

  Item findItemToUpdate(id) {
    int itemIndex = _items.indexWhere((item) => item.id == id);
    return _items[itemIndex];
  }

  Future<void> getData() async {
    try {
      List data = await DBHelper.fetch();
      _items = data.map((e) {
        return Item(id: e['id'], name: e['name'], age: e['age']);
      }).toList();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> addData(name, age) async {
    try {
      Map<String, Object> data = {'name': name, 'age': age};
      await DBHelper.insert(data);
    } catch (e) {
      print('hello');
      print(e);
    }
  }

  Future<void> update(data) async {
    final updatedData =
        Item(name: data['name'], id: data['id'], age: (data['age']));

    try {
      await DBHelper.update(data);
      int findIndex = _items.indexWhere((item) => item.id == updatedData.id);
      _items[findIndex] = updatedData;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteData(id) async {
    try {
      await DBHelper.delete(id);
      _items.removeWhere((item) => item.id == id);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
