import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payment_integration/core/utils/styles.dart';
import 'package:payment_integration/features/checkout/presentation/views/payment_success/widgets/card_info_widget.dart';
import 'package:payment_integration/features/checkout/presentation/views/payment_success/widgets/custom_dashed_line.dart';
import 'package:payment_integration/features/checkout/presentation/views/payment_success/widgets/payment_success_item_info.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
      body: Transform.translate(
        offset: const Offset(0, -18),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xffEDEDED)),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 50 + 12,
                    left: 15,
                    right: 15,
                  ),
                  child: Column(children: [
                    const Text("Thank you!", style: Styles.style25),
                    Text(
                      "Your transaction was successful",
                      style: Styles.style20.copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const PaymentSuccessItemInfo(
                        text1: "Date", text2: "01/24/2023"),
                    const SizedBox(
                      height: 15,
                    ),
                    const PaymentSuccessItemInfo(
                        text1: "Time", text2: "10:15 AM"),
                    const SizedBox(
                      height: 15,
                    ),
                    const PaymentSuccessItemInfo(
                        text1: "To", text2: "Sam Louis"),
                    const Divider(
                      height: 30,
                      thickness: 2,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total", style: Styles.style24),
                        Text("\$50.97", style: Styles.style24),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const CardInfoWidget(),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          FontAwesomeIcons.barcode,
                          size: 60,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 113,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color(0xff34A853),
                            ),
                          ),
                          child: const Text("PAID", style: Styles.styleGreen24),
                        ),
                      ],
                    ),
                    SizedBox(
                      height:
                          ((MediaQuery.sizeOf(context).height * 0.2 + 20) / 2) -
                              29,
                    ),
                  ]),
                ),
              ),
              Positioned(
                  bottom: MediaQuery.sizeOf(context).height * 0.2 + 20,
                  left: 20 + 16,
                  right: 20 + 16,
                  child: const CustomDashedLine()),
              Positioned(
                  bottom: MediaQuery.sizeOf(context).height * 0.2,
                  left: -20,
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                  )),
              Positioned(
                  bottom: MediaQuery.sizeOf(context).height * 0.2,
                  right: -20,
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                  )),
              const Positioned(
                  left: 0,
                  right: 0,
                  top: -50,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xffd9d9d9),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xff34A853),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
