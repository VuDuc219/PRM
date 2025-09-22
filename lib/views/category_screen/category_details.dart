import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myapp/services/firestore_services.dart';
import 'package:myapp/views/category_screen/item_details.dart';
import 'dart:developer' as developer;

class CategoryDetails extends StatelessWidget {
  final String title;

  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    developer.log(
      "Fetching products for category: $title",
      name: "CategoryDetails",
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ), // Ensure back button is white
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirestoreServices.getProductsByCategory(title).first,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.deepPurple),
            );
          }
          if (snapshot.hasError) {
            developer.log(
              "Error fetching products: ${snapshot.error}",
              name: "CategoryDetails",
              error: snapshot.error,
            );
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            developer.log(
              "No products found for category: $title",
              name: "CategoryDetails",
            );
            return const Center(
              child: Text(
                "No products found in this category.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          final data = snapshot.data!.docs;
          developer.log(
            "Found ${data.length} products for category: $title",
            name: "CategoryDetails",
          );

          return GridView.builder(
            padding: const EdgeInsets.all(12.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12.0,
              crossAxisSpacing: 12.0,
              childAspectRatio: 0.75,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              var product = data[index].data() as Map<String, dynamic>;
              product['id'] = data[index].id;

              return InkWell(
                onTap: () {
                  Get.to(() => ItemDetails(data: product));
                },
                child: Card(
                  elevation: 4,
                  shadowColor: Colors.grey.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.network(
                            (product['p_imgs'] is List &&
                                    product['p_imgs'].isNotEmpty)
                                ? product['p_imgs'][0]
                                : '',
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                                  Icons.broken_image,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['p_name'] ?? 'No Name',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              (product['p_price'] is List &&
                                      product['p_price'].isNotEmpty)
                                  ? '${product['p_price'][0]} VND'
                                  : 'N/A',
                              style: const TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
