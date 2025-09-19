import 'package:flutter/material.dart';
import 'package:myapp/consts/consts.dart';

Widget homeButton({
  double? width,
  double? height,
  String? icon,
  String? title,
  VoidCallback? onPress,
}) {
  return GestureDetector(
    onTap: onPress,
    child: Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon!, width: 26),
          const SizedBox(height: 8),
          Text(
            title!,
            style: const TextStyle(fontFamily: semibold, color: darkFontGrey),
          ),
        ],
      ),
    ),
  );
}
