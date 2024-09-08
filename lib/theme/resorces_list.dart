import 'package:flutter/material.dart';


class ShareData {
  late String receiver;
  late String coffee;

  ShareData(this.receiver, this.coffee);

  ShareData.fromJson(Map<String, dynamic> json){
    this.receiver = json['receiver'];
    this.coffee = json['data'];
  }

  Map<String, dynamic> toJson() {
    return {
      "receiver": receiver,
      "data": coffee
    };
  }
}


class Coffee {
  final int category;
  final AssetImage image;
  final num ratting;
  final String name;
  final String mix;
  final num price;
  final num mediumPrice;
  final num largePrice;
  final num mediumRating;
  final num largeRating;
  final String prefix;
  final String prefixMedium;
  final String prefixLarge;

  Coffee({
    required this.category,
    required this.image,
    required this.ratting,
    required this.name,
    required this.mix,
    required this.price,
    required this.mediumPrice,
    required this.largePrice,
    required this.mediumRating,
    required this.largeRating,
    required this.prefix,
    required this.prefixMedium,
    required this.prefixLarge,
  });

  Map<String, dynamic> toJson(String size) {
    return {
      'size': size,
      'category': category,
      'image': image.assetName,
      'ratting': ratting,
      'name': name,
      'mix': mix,
      'price': price,
      'mediumPrice': mediumPrice,
      'largePrice': largePrice,
      'mediumRating': mediumRating,
      'largeRating': largeRating,
      'prefix': prefix,
      'prefixMedium': prefixMedium,
      'prefixLarge': prefixLarge,
    };
  }

  factory Coffee.fromJson(Map<String, dynamic> json) {
    return Coffee(
      category: json['category'] as int,
      image: AssetImage(json['image'] as String),
      ratting: json['ratting'] as num,
      name: json['name'] as String,
      mix: json['mix'] as String,
      price: json['price'] as num,
      mediumPrice: json['mediumPrice'] as num,
      largePrice: json['largePrice'] as num,
      mediumRating: json['mediumRating'] as num,
      largeRating: json['largeRating'] as num,
      prefix: json['prefix'] as String,
      prefixMedium: json['prefixMedium'] as String,
      prefixLarge: json['prefixLarge'] as String,
    );
  }

  String getPrice(String size){
    return "${size == "S" ? price : size == "M" ? mediumPrice : largePrice}";
  }
}

final _goods = <Coffee>[];

List<Coffee> get coffees {
  if(_goods.isEmpty) {
    _goods.addAll(_generateCoffeeList());
  }
  return _goods;
}


List<Coffee> _generateCoffeeList() {

  List<Coffee> coffeeList = [];

  for (int i = 0; i < _images.length; i++) {
    coffeeList.add(Coffee(
      category: i % 3,
      image: _images[i],
      ratting: _ratting[i],
      name: _names[i % _names.length],
      mix: _with[i],
      price: num.parse(_prices[i]),
      mediumPrice: num.parse(_mediumPrice[i]),
      largePrice: num.parse(_largePrice[i]),
      mediumRating: _mediumRating[i],
      largeRating: _largeRating[i],
      prefix: _prefix[i],
      prefixMedium: _prefixMedium[i],
      prefixLarge: _prefixLarge[i],
    ));
  }

  return coffeeList;
}

var _category=[
  true,
  false,
  false,
  false,
  false,
];
var _images = [
  const AssetImage("assets/images/s2.jpeg"),
  const AssetImage("assets/images/s4.jpeg"),
  const AssetImage("assets/images/s3.jpeg"),
  const AssetImage("assets/images/p1.jpeg"),
  const AssetImage("assets/images/p3.jpeg"),
  const AssetImage("assets/images/p4.jpeg"),
  const AssetImage("assets/images/p5.jpeg"),
  const AssetImage("assets/images/s1.jpeg"),
  const AssetImage("assets/images/p6.jpeg"),
  const AssetImage("assets/images/p2.jpeg"),
];
var _ratting = [
  4.2,
  4.5,
  4.1,
  4.0,
  2.2,
  3.2,
  1.2,
  3.2,
  3.6,
  4.8,
];
var _names = [
  "Cappuccino",
  "Espresso",
  "Red Eye",
  "Black Eye",
  "Americano",
  "Long Black",
  "Machination",
  "Macchiato",
  "Double",
];
var _with=[
  "with Oat Milk",
  "with Chocolate",
  "with White Milk",
  "with Oat Milk",
  "with Chocolate",
  "with White Milk",
  "with Oat Milk",
  "with Chocolate",
  "with White Milk",
  "with Oat Milk",
  "with Chocolate",
  "with White Milk",

];
var _prices=[
  "4",
  "5",
  "2",
  "7",
  "1",
  "6",
  "2",
  "7",
  "9",
  "5",
];
var _mediumRating = [
  3.2,
  2.3,
  4.3,
  1.9,
  3.8,
  1.8,
  3.6,
  2.7,
  1.6,
  4.5,
];
var _largeRating = [
  3.2,
  2.3,
  1.8,
  3.6,
  2.7,
  1.6,
  4.5,
  4.3,
  1.9,
  3.8,
];
var _prefix = [
  "(5.753)",
  "(3.343)",
  "(4.653)",
  "(1.49)",
  "(4.353)",
  "(6.333)",
  "(2.743)",
  "(4.355)",
  "(2.443)",
  "(1.123)",
];
var _prefixMedium = [
  "(2.443)",
  "(5.753)",
  "(3.343)",
  "(4.653)",
  "(6.333)",
  "(2.743)",
  "(4.355)",
  "(1.49)",
  "(4.353)",
  "(1.123)",
];
var _prefixLarge = [
  "(4.653)",
  "(1.49)",
  "(2.743)",
  "(4.355)",
  "(5.753)",
  "(3.343)",
  "(2.443)",
  "(4.353)",
  "(6.333)",
  "(1.123)",
];
var _mediumPrice = [
  "5",
  "6",
  "3",
  "4",
  "2",
  "7",
  "3",
  "8",
  "10",
  "6",
];
var _largePrice = [
  "6",
  "7",
  "4",
  "5",
  "3",
  "8",
  "3",
  "9",
  "11",
  "7",
];