import 'package:flutter/material.dart';
import 'package:payment_integration/core/utils/styles.dart';

class PaymentSuccessItemInfo extends StatelessWidget {
  const PaymentSuccessItemInfo(
      {super.key, required this.text1, required this.text2});
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text1, style: Styles.style18),
        Text(text2, style: Styles.styleBold18)
      ],
    );
  }
}
