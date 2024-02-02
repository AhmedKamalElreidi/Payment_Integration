import 'package:flutter/material.dart';
import 'package:payment_integration/core/utils/styles.dart';

class OrderInfoItem extends StatelessWidget {
  const OrderInfoItem({super.key, required this.text1, required this.text2});
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text1, style: Styles.style18),
        Text(text2, style: Styles.style18),
      ],
    );
  }
}
