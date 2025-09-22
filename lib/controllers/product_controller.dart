import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/consts/firebase_consts.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductController extends GetxController {
  var quantity = 1.obs; // Default quantity to 1
  var sizeIndex = 0.obs;
  var totalPrice = 0.obs;
  var priceList = <int>[].obs; // To store the list of prices for the product
  var userRating = 0.0.obs; // To store the user's rating selection

  // Add to cart method
  addToCart({
    required String title,
    required String img,
    required String size,
    required int qty,
    required int tprice,
    required BuildContext context,
  }) async {
    try {
      await firestore.collection(cartCollection).doc().set({
        'title': title,
        'img': img,
        'size': size,
        'qty': qty,
        'tprice': tprice,
        'added_by': auth.currentUser!.uid,
      });
      VxToast.show(context, msg: "Added to cart");
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  // Initialize or reset the controller's state when viewing a new product
  void initData(List<dynamic> prices) {
    quantity.value = 1; // Reset quantity to 1
    sizeIndex.value = 0; // Reset to the first size
    userRating.value = 0.0; // Reset user rating
    // Convert the dynamic list of prices (e.g., ["40000", "50000"]) to a list of integers
    priceList.value = prices
        .map((p) => int.tryParse(p.toString()) ?? 0)
        .toList();
    calculateTotalPrice(); // Calculate the initial total price
  }

  // Called when the user selects a different size chip
  void changeSizeIndex(int index) {
    sizeIndex.value = index;
    calculateTotalPrice(); // Recalculate the price for the new size
  }

  // Increases the quantity, up to the available stock
  void increaseQuantity(int availableStock) {
    if (quantity.value < availableStock) {
      quantity.value++;
      calculateTotalPrice();
    }
  }

  // Decreases the quantity, but not below 1
  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
      calculateTotalPrice();
    }
  }

  // Calculates the total price based on the selected size and quantity
  void calculateTotalPrice() {
    // Ensure the price list is not empty and the index is valid
    if (priceList.isNotEmpty && sizeIndex.value < priceList.length) {
      totalPrice.value = priceList[sizeIndex.value] * quantity.value;
    } else {
      totalPrice.value = 0; // Default to 0 if something is wrong
    }
  }

  // Updates the user's rating
  void updateUserRating(double rating) {
    userRating.value = rating;
  }
}
