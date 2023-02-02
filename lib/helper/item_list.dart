import 'dart:convert';

import 'package:fake_store/helper/item_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemList extends ChangeNotifier {
  List<ItemData> _items = [];

  void addItem(ItemData itemData) async {
    _items.add(itemData);
    var data = json.encode(_items);
    setItemList(data);
    getItemList();

    notifyListeners();
  }

  Future setItemList(String itemData) async {
    // String json = "[" + itemData + "]";
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString("itemList", itemData);
  }

  Future<List<ItemData>> getItemList() async {
    List<ItemData> itemList = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jsonData = null != preferences.getString("itemList")
        ? preferences.getString("itemList")!
        : "";
    if (jsonData.isNotEmpty) {
      var data = jsonDecode(jsonData);
      itemList = List<ItemData>.from(data.map((x) => ItemData.fromJson(x)));
      _items = itemList;
    }
    return _items;
  }

  void deleteItem(int number) async {
    final prefs = await SharedPreferences.getInstance();
    _items.removeAt(number);
    var data = json.encode(_items);
    setItemList(data);
    getItemList();

    notifyListeners();
  }

  List<ItemData> get basketItem {
    getItemList();
    return _items;
  }
}
