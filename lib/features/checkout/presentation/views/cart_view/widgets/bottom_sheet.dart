import 'dart:developer';

import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:payment_integration/core/functions/app_functions.dart';
import 'package:payment_integration/core/utils/constants/api_keys.dart';
import 'package:payment_integration/core/widgets/custom_button.dart';
import 'package:payment_integration/features/checkout/data/models/paypal/amount_model/amount_model.dart';
import 'package:payment_integration/features/checkout/data/models/paypal/amount_model/details.dart';
import 'package:payment_integration/features/checkout/data/models/paypal/item_list_model/item.dart';
import 'package:payment_integration/features/checkout/data/models/paypal/item_list_model/item_list_model.dart';
import 'package:payment_integration/features/checkout/presentation/view_model/cubit/payment_cubit.dart';
import 'package:payment_integration/features/checkout/presentation/views/payment_details/widgets/payment_method_item.dart';
import 'package:payment_integration/features/checkout/presentation/views/payment_success/payment_success.dart';

class PaymentBottomSheet extends StatefulWidget {
  const PaymentBottomSheet({super.key});

  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  List<String> images = [
    "assets/images/card.svg",
    "assets/images/paypal.svg",
  ];

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
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
          const SizedBox(
            height: 32,
          ),
          BlocConsumer<PaymentCubit, PaymentState>(
            listener: (context, state) {
              if (state is PaymentSuccessState) {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return const PaymentSuccess();
                }));
              }
              if (state is PaymentFailure) {
                Navigator.of(context).pop();
                AppFunctions.showToast(text: state.errMessage);
              }
            },
            builder: (context, state) {
              // var cubit = PaymentCubit.get(context);
              return AnimatedConditionalBuilder(
                  condition: state is PaymentLoadingState,
                  builder: (BuildContext context) =>
                      const Center(child: CircularProgressIndicator()),
                  fallback: (BuildContext context) => CustomButton(
                      title: "Continune",
                      onTap: () {
                        // PaymentIntentInputModel paymentIntentInputModel =
                        //     PaymentIntentInputModel(
                        //         amount: "100",
                        //         currency: "USD",
                        //         customerId: ApiKeys.customerId);
                        // cubit.makePayment(
                        //     paymentIntentInputModel: paymentIntentInputModel);

                        var amount = AmountModel(
                            total: '100',
                            currency: 'USD',
                            details: Details(
                                shipping: '0',
                                shippingDiscount: 0,
                                subtotal: '100'));
                        List<OrderItemModel> orders = [
                          OrderItemModel(
                              currency: 'USD',
                              name: 'Apple',
                              price: '4',
                              quantity: 10),
                          OrderItemModel(
                              currency: 'USD',
                              name: 'Apple',
                              price: '5',
                              quantity: 12)
                        ];
                        var itemList = ItemListModel(
                          items: orders,
                        );
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => PaypalCheckoutView(
                            sandboxMode: true,
                            clientId: ApiKeys.paypalClientId,
                            secretKey: ApiKeys.paypalSecretKey,
                            transactions: [
                              {
                                "amount": amount.toJson(),
                                "description":
                                    "The payment transaction description.",
                                "item_list": itemList.toJson(),
                              }
                            ],
                            note: "Contact us for any questions on your order.",
                            onSuccess: (Map params) async {
                              log("onSuccess: $params");
                              Navigator.pop(context);
                            },
                            onError: (error) {
                              log("onError: $error");
                              Navigator.pop(context);
                            },
                            onCancel: () {
                              print('cancelled:');
                              Navigator.pop(context);
                            },
                          ),
                        ));
                        ////////////
                      }));
            },
          ),
        ],
      ),
    );
  }

  // void executePaypalPaymentMethod(
  //     BuildContext context, AmountModel amount, ItemListModel itemList) {
  //   Navigator.of(context).push(MaterialPageRoute(
  //     builder: (BuildContext context) => PaypalCheckoutView(
  //       sandboxMode: true,
  //       clientId: ApiKeys.paypalClientId,
  //       secretKey: ApiKeys.paypalSecretKey,
  //       transactions: [
  //         {
  //           "amount": amount.toJson(),
  //           "description": "The payment transaction description.",
  //           "item_list": {
  //             "items": itemList.toJson(),
  //           }
  //         }
  //       ],
  //       note: "Contact us for any questions on your order.",
  //       onSuccess: (Map params) async {
  //         log("onSuccess: $params");
  //         Navigator.pop(context);
  //       },
  //       onError: (error) {
  //         log("onError: $error");
  //         Navigator.pop(context);
  //       },
  //       onCancel: () {
  //         print('cancelled:');
  //         Navigator.pop(context);
  //       },
  //     ),
  //   ));
  // }
}
