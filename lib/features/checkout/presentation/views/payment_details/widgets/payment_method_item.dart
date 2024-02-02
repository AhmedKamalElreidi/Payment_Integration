import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PaymentMethodItem extends StatelessWidget {
  const PaymentMethodItem(
      {super.key, this.isActive = false, required this.image});
  final bool isActive;
  final String image;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 103,
      height: 62,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: isActive ? const Color(0xff34A853) : Colors.grey,
              width: 1.5),
          boxShadow: [
            BoxShadow(
              color: isActive ? const Color(0xff34A853) : Colors.white,
              spreadRadius: 0,
              blurRadius: 4,
            ),
          ]),
      child: Center(
        child: SvgPicture.asset(
          image,
          // height: 35,
        ),
      ),
    );
  }
}
