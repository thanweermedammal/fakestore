// To parse this JSON data, do
//
//     final itemData = itemDataFromJson(jsonString);

import 'dart:convert';

ItemData itemDataFromJson(String str) => ItemData.fromJson(json.decode(str));

String itemDataToJson(ItemData data) => json.encode(data.toJson());

class ItemData {
  ItemData({
    this.title,
    this.image,
    this.price,
  });

  String? title;
  String? image;
  double? price;

  factory ItemData.fromJson(Map<String, dynamic> json) => ItemData(
        title: json["title"],
        image: json["image"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
        "price": price,
      };
}
