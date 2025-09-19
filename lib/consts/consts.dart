import 'package:flutter/material.dart';

// Colors
const Color textfieldGrey = Color.fromRGBO(209, 209, 209, 1);
const Color fontGrey = Color.fromRGBO(107, 107, 107, 1);
const Color darkFontGrey = Color.fromRGBO(62, 68, 71, 1);
const Color whiteColor = Color.fromRGBO(255, 255, 255, 1);
const Color lightGrey = Color.fromRGBO(239, 239, 239, 1);
const Color redColor = Color.fromRGBO(230, 46, 4, 1);
const Color golden = Color.fromRGBO(255, 168, 0, 1);

// Font Families
const String regular = "sans_regular";
const String semibold = "sans_semibold";
const String bold = "sans_bold";

// Image paths
const icTodaysSpecial = "assets/icons/todays_deal.png";
const icBestSellers = "assets/icons/flash_deal.png";

const List<String> slidersList = [
  'assets/images/banner1.png',
  'assets/images/banner2.png',
  'assets/images/banner3.png',
  'assets/images/banner4.png',
];

const List<Map<String, dynamic>> featuredProducts = [
  {
    'name': 'Cappuccino',
    'price': '5.12',
    'image': 'assets/images/cappuccino.png',
  },
  {'name': 'Latte', 'price': '4.50', 'image': 'assets/images/cappuccino.png'},
  {
    'name': 'Espresso',
    'price': '3.80',
    'image': 'assets/images/cappuccino.png',
  },
  {'name': 'Mocha', 'price': '5.50', 'image': 'assets/images/cappuccino.png'},
];

const List<Map<String, String>> categories = [
  {'name': 'Cappuccino', 'image': 'assets/images/coffee_cup.png'},
  {'name': 'Espresso', 'image': 'assets/images/coffee_cup.png'},
  {'name': 'Latte', 'image': 'assets/images/coffee_cup.png'},
  {'name': 'Mocha', 'image': 'assets/images/coffee_cup.png'},
  {'name': 'Americano', 'image': 'assets/images/coffee_cup.png'},
  {'name': 'Macchiato', 'image': 'assets/images/coffee_cup.png'},
  {'name': 'Frappe', 'image': 'assets/images/coffee_cup.png'},
  {'name': 'Iced Coffee', 'image': 'assets/images/coffee_cup.png'},
  {'name': 'Tea', 'image': 'assets/images/coffee_cup.png'},
];

const Map<String, List<Map<String, String>>> productDetails = {
  'Cappuccino': [
    {
      'name': 'Classic Cappuccino',
      'price': '\$5.12',
      'image': 'assets/images/coffee_cup.png',
    },
    {
      'name': 'Iced Cappuccino',
      'price': '\$5.50',
      'image': 'assets/images/coffee_cup.png',
    },
    {
      'name': 'Caramel Cappuccino',
      'price': '\$5.80',
      'image': 'assets/images/coffee_cup.png',
    },
    {
      'name': 'Hazelnut Cappuccino',
      'price': '\$5.80',
      'image': 'assets/images/coffee_cup.png',
    },
  ],
  'Espresso': [
    {
      'name': 'Single Espresso',
      'price': '\$3.80',
      'image': 'assets/images/coffee_cup.png',
    },
    {
      'name': 'Doppio',
      'price': '\$4.20',
      'image': 'assets/images/coffee_cup.png',
    },
    {
      'name': 'Espresso Macchiato',
      'price': '\$4.50',
      'image': 'assets/images/coffee_cup.png',
    },
    {
      'name': 'Iced Shaken Espresso',
      'price': '\$5.00',
      'image': 'assets/images/coffee_cup.png',
    },
  ],
  'Latte': [
    {
      'name': 'Classic Latte',
      'price': '\$4.50',
      'image': 'assets/images/coffee_cup.png',
    },
    {
      'name': 'Vanilla Latte',
      'price': '\$5.00',
      'image': 'assets/images/coffee_cup.png',
    },
    {
      'name': 'Iced Latte',
      'price': '\$5.00',
      'image': 'assets/images/coffee_cup.png',
    },
    {
      'name': 'Chai Latte',
      'price': '\$5.20',
      'image': 'assets/images/coffee_cup.png',
    },
  ],
  'Mocha': [
    {
      'name': 'Classic Mocha',
      'price': '\$5.50',
      'image': 'assets/images/coffee_cup.png',
    },
    {
      'name': 'White Mocha',
      'price': '\$5.80',
      'image': 'assets/images/coffee_cup.png',
    },
    {
      'name': 'Iced Mocha',
      'price': '\$5.80',
      'image': 'assets/images/coffee_cup.png',
    },
    {
      'name': 'Peppermint Mocha',
      'price': '\$6.00',
      'image': 'assets/images/coffee_cup.png',
    },
  ],
  'Americano': [
    {
      'name': 'Classic Americano',
      'price': '\$4.00',
      'image': 'assets/images/coffee_cup.png',
    },
    {
      'name': 'Iced Americano',
      'price': '\$4.20',
      'image': 'assets/images/coffee_cup.png',
    },
  ],
  'Macchiato': [
    {
      'name': 'Caramel Macchiato',
      'price': '\$5.20',
      'image': 'assets/images/coffee_cup.png',
    },
    {
      'name': 'Iced Caramel Macchiato',
      'price': '\$5.50',
      'image': 'assets/images/coffee_cup.png',
    },
  ],
  'Frappe': [
    {
      'name': 'Coffee Frappe',
      'price': '\$6.00',
      'image': 'assets/images/coffee_cup.png',
    },
    {
      'name': 'Mocha Frappe',
      'price': '\$6.20',
      'image': 'assets/images/coffee_cup.png',
    },
  ],
  'Iced Coffee': [
    {
      'name': 'Classic Iced Coffee',
      'price': '\$4.50',
      'image': 'assets/images/coffee_cup.png',
    },
    {
      'name': 'Cold Brew',
      'price': '\$5.00',
      'image': 'assets/images/coffee_cup.png',
    },
  ],
  'Tea': [
    {
      'name': 'Green Tea',
      'price': '\$3.50',
      'image': 'assets/images/coffee_cup.png',
    },
    {
      'name': 'Black Tea',
      'price': '\$3.50',
      'image': 'assets/images/coffee_cup.png',
    },
  ],
};

const Map<String, String> itemDetail = {
  'rating': '4.5',
  'reviews': '2330',
  'description':
      'A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the fo.. Read More',
};
