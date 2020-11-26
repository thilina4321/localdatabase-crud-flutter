import 'package:flutter/cupertino.dart';
import 'package:localdatastorage/helper/db_helper.dart';

class Item {
  int id;
  String name;
  int value;

  Item({this.id, this.name, this.value});
}

class ItemProvider with ChangeNotifier {
  List<Item> _items;

  List<Item> get items {
    return [..._items];
  }

  Future<void> addData(name, value) async {
    Map<String, Object> data = {'name': name, 'value': value};
    await DBHelper.insert(data);
  }

  Item findItemToUpdate(id) {
    int itemIndex = _items.indexWhere((item) => item.id == id);
    return _items[itemIndex];
  }

  Future<void> getData() async {
    try {
      List data = await DBHelper.fetch();
      _items = data.map((e) {
        return Item(id: e['id'], name: e['name'], value: e['value']);
      }).toList();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> update(data) async {
    final updatedData =
        Item(name: data['name'], id: data['id'], value: (data['value']));

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
