import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/consts/firebase_consts.dart';
import 'package:myapp/controllers/cart_controller.dart';
import 'package:myapp/services/firestore_services.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.put(CartController());

    return Scaffold(
      backgroundColor: const Color(0xff27221f), // Coffee-brown background
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Shopping Cart',
          style: TextStyle(fontFamily: semibold, color: Colors.white), // White title
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirestoreServices.getCart(auth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: golden),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/empty_cart.png', width: 150),
                  const SizedBox(height: 20),
                  const Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: semibold,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Looks like you haven\'t added anything to your cart yet.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white60),
                  ),
                ],
              ),
            );
          }

          var data = snapshot.data!.docs;
          controller.calculate(data);

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var item = data[index];
                    int unitPrice = item['tprice'] ~/ item['qty'];

                    return Card(
                      elevation: 4,
                      color: const Color(0xff39322d), // Lighter brown for cards
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            item['img'],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          item['title'],
                          style: const TextStyle(fontFamily: bold, fontSize: 16, color: Colors.white),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Size: ${item['size']}',
                              style: const TextStyle(color: Colors.white70),
                            ),
                            Text(
                              '${item['tprice']} VND',
                              style: const TextStyle(
                                fontFamily: semibold,
                                color: golden, // Use golden for price
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline, color: Colors.white70),
                              onPressed: () {
                                controller.updateQuantity(
                                  docId: item.id,
                                  newQuantity: item['qty'] - 1,
                                  unitPrice: unitPrice,
                                );
                              },
                            ),
                            Text('${item['qty']}', style: const TextStyle(color: Colors.white)),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline, color: Colors.white70),
                              onPressed: () {
                                controller.updateQuantity(
                                  docId: item.id,
                                  newQuantity: item['qty'] + 1,
                                  unitPrice: unitPrice,
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () {
                                controller.deleteItem(item.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Obx(
                () => Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Color(0xff39322d), // Match card color
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Price',
                            style: TextStyle(fontFamily: bold, fontSize: 18, color: Colors.white),
                          ),
                          Text(
                            '${controller.totalP.value} VND',
                            style: const TextStyle(
                              fontFamily: bold,
                              fontSize: 18,
                              color: golden, // Use golden for total price
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: golden,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            'Proceed to Shipping',
                            style: TextStyle(
                              color: darkFontGrey, // Darker text for button
                              fontFamily: semibold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
