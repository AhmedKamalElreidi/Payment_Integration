import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:payment_integration/core/utils/styles.dart';
import 'package:payment_integration/core/widgets/custom_button.dart';
import 'package:payment_integration/features/checkout/presentation/views/payment_details/widgets/custom_credit_card.dart';
import 'package:payment_integration/features/checkout/presentation/views/payment_details/widgets/payment_method_item.dart';
import 'package:payment_integration/features/checkout/presentation/views/payment_success/payment_success.dart';

class PaymentDetailsView extends StatefulWidget {
  const PaymentDetailsView({super.key});

  @override
  State<PaymentDetailsView> createState() => _PaymentDetailsViewState();
}

class _PaymentDetailsViewState extends State<PaymentDetailsView> {
  int activeIndex = 0;
  List<String> images = [
    "assets/images/card.svg",
    "assets/images/paypal.svg",
    "assets/images/master_card.svg"
  ];
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Payment Details", style: Styles.style25),
        centerTitle: true,
        leading: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(
              "assets/images/arrow.svg",
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // payment method item
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < images.length; i++)
                  GestureDetector(
                    onTap: () {
                      activeIndex = i;
                      setState(() {});
                    },
                    child: PaymentMethodItem(
                      isActive: activeIndex == i,
                      image: images[i],
                    ),
                  ),
              ],
            ),
          ),
          // Custom Credit Card Ui
          SliverToBoxAdapter(
              child: CustomCreditCard(
            formKey: formKey,
            autovalidateMode: autovalidateMode,
          )),
          SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: CustomButton(
                        title: "Pay",
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                          } else {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const PaymentSuccess();
                            }));
                            autovalidateMode = AutovalidateMode.always;
                            setState(() {});
                          }
                        }),
                  ))),
        ],
      ),
    );
  }
}
