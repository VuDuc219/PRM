import 'package:get/get.dart';
import 'package:myapp/consts/firebase_consts.dart';
import 'package:myapp/services/firestore_services.dart';

class CartController extends GetxController {
  var totalP = 0.obs;

  // Calculate total price
  void calculate(dynamic data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  // Update quantity and total price for an item
  void updateQuantity({required String docId, required int newQuantity, required int unitPrice}) {
    if (newQuantity > 0) {
      firestore.collection(cartCollection).doc(docId).update({
        'qty': newQuantity,
        'tprice': newQuantity * unitPrice,
      });
    } else {
      // If quantity drops to 0 or less, delete the item
      deleteItem(docId);
    }
  }

  // Delete an item from the cart
  void deleteItem(String docId) {
    FirestoreServices.deleteDocument(docId);
  }
}
