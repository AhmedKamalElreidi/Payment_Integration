import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payment_integration/core/utils/styles.dart';
import 'package:payment_integration/core/widgets/custom_button.dart';
import 'package:payment_integration/features/checkout/data/repo/checkout_repo_impl.dart';
import 'package:payment_integration/features/checkout/presentation/view_model/cubit/payment_cubit.dart';
import 'package:payment_integration/features/checkout/presentation/views/cart_view/widgets/bottom_sheet.dart';
import 'package:payment_integration/features/checkout/presentation/views/cart_view/widgets/cart_info_item.dart';

class MyCartView extends StatelessWidget {
  const MyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("My Cart", style: Styles.style25),
        centerTitle: true,
        leading: Center(
          child: SvgPicture.asset(
            "assets/images/arrow.svg",
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 18,
            ),
            Expanded(child: Image.asset("assets/images/basket_image.png")),
            const SizedBox(
              height: 25,
            ),
            const OrderInfoItem(text1: "Order Subtotal", text2: "\$43.23"),
            const SizedBox(
              height: 3,
            ),
            const OrderInfoItem(text1: "Discount", text2: "\$0"),
            const SizedBox(
              height: 3,
            ),
            const OrderInfoItem(text1: "Shipping", text2: "\$8"),
            const Divider(
              thickness: 2,
              color: Color(0xffC7C7C7),
              height: 34,
            ),
            // total prize
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total", style: Styles.style24),
                Text("\$50.97", style: Styles.style24),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            // Button
            CustomButton(
              title: "Complete Payment",
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    builder: (context) {
                      return BlocProvider(
                        create: (context) => PaymentCubit(CheckoutRepoImpl()),
                        child: const PaymentBottomSheet(),
                      );
                    });
              },
            ),
            const SizedBox(
              height: 17,
            ),
          ],
        ),
      ),
    );
  }
}
