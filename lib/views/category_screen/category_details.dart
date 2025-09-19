import 'package:flutter/material.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/views/category_screen/category_screen.dart';
import 'package:myapp/views/category_screen/item_details.dart';

class CategoryDetails extends StatelessWidget {
  final String categoryTitle;

  const CategoryDetails({super.key, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    // This will be replaced with actual data from a database
    final List<Map<String, String>> products =
        productDetails[categoryTitle] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFEFEBE9),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const CategoryScreen()),
            );
          },
        ),
        title: Text(
          categoryTitle,
          style: const TextStyle(fontFamily: bold, color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: products.length, // Dynamic item count
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemDetails(item: products[index]),
                  ),
                );
              },
              child: Card(
                elevation: 3,
                shadowColor: Colors.black.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Center(
                          child: Image.asset(
                            products[index]['image']!,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        products[index]['name']!,
                        style: const TextStyle(
                          fontFamily: semibold,
                          color: darkFontGrey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        products[index]['price']!,
                        style: const TextStyle(
                          fontFamily: bold,
                          color: redColor, // Using a defined color constant
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
