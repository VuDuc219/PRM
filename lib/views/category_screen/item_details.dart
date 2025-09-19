import 'package:flutter/material.dart';
import 'package:myapp/consts/consts.dart';

class ItemDetails extends StatefulWidget {
  final Map<String, String> item;

  const ItemDetails({super.key, required this.item});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  int _selectedSizeIndex = 1; // Default to medium

  @override
  Widget build(BuildContext context) {
    final itemDetails = itemDetail; // Corrected this line

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 300,
                child: Center(
                  child: Image.asset(
                    'assets/images/coffee_cup.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.item['name']!,
                      style: const TextStyle(
                        fontFamily: bold,
                        fontSize: 24,
                        color: darkFontGrey,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: golden, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        itemDetails['rating']!,
                        style: const TextStyle(
                          fontFamily: bold,
                          fontSize: 16,
                          color: darkFontGrey,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${itemDetails['reviews']!})',
                        style: const TextStyle(
                          fontFamily: regular,
                          fontSize: 16,
                          color: fontGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Description',
                style: TextStyle(
                  fontFamily: bold,
                  fontSize: 18,
                  color: darkFontGrey,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                itemDetails['description']!,
                style: const TextStyle(
                  fontFamily: regular,
                  fontSize: 16,
                  color: fontGrey,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Size',
                style: TextStyle(
                  fontFamily: bold,
                  fontSize: 18,
                  color: darkFontGrey,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(3, (index) {
                  final sizes = ['S', 'M', 'L'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedSizeIndex = index;
                      });
                    },
                    child: Container(
                      width: 80,
                      height: 50,
                      decoration: BoxDecoration(
                        color: _selectedSizeIndex == index
                            ? golden.withOpacity(0.2)
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _selectedSizeIndex == index
                              ? golden
                              : Colors.grey[300]!,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          sizes[index],
                          style: TextStyle(
                            fontFamily: bold,
                            fontSize: 16,
                            color: _selectedSizeIndex == index
                                ? golden
                                : darkFontGrey,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Price',
                  style: TextStyle(
                    fontFamily: regular,
                    fontSize: 16,
                    color: fontGrey,
                  ),
                ),
                Text(
                  widget.item['price']!,
                  style: const TextStyle(
                    fontFamily: bold,
                    fontSize: 24,
                    color: redColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 180,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: golden,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(
                    fontFamily: bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
