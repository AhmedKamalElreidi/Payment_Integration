import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:payment_integration/core/utils/styles.dart';

class CardInfoWidget extends StatelessWidget {
  const CardInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 305,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: Row(
        children: [
          SvgPicture.asset("assets/images/master_card.svg"),
          const SizedBox(
            width: 23,
          ),
          const Text("Credit Card\nMastercard **78 ", style: Styles.style18),
        ],
      ),
    );
  }
}
