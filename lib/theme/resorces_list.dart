import 'package:flutter/material.dart';

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
  "5.10",
  "6.20",
  "3.56",
  "4.77",
  "2.64",
  "7.25",
  "3.86",
  "8.56",
  "10.84",
  "6.98",
];
var _largePrice = [
  "6.03",
  "7.21",
  "4.23",
  "5.45",
  "3.32",
  "8.44",
  "3.09",
  "9.87",
  "11.63",
  "7.57",
];