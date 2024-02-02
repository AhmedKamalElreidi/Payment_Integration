//stripe flow
// 1- create payment intent (amount, currency,Customer Id عشان ابقى عارف مين اللى هيدفع ولو جيت استخدمت الكارت تانى البيانات تظهر )
// - return paymentintentobject and i will extraxt from it the value i need
// - createEphemeralKey(customerId)  ----> return KeySecret  ----- StripeVersion put in headers
// - Api request dio
// - create models 1- for the return paymentintentobject 2- for input models (amount, currency, .....)
// 2- initPaymentSheet (merchantDisplayName,intentClientSecret,ephmeralKeySecret)
// 3- present payment sheet
// 4- هعمل كلاس واحط فى كل الحاجات اللى فاتت  دى

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_integration/core/helper/api_services.dart';
import 'package:payment_integration/core/utils/constants/api_keys.dart';
import 'package:payment_integration/core/utils/constants/endpoint.dart';
import 'package:payment_integration/features/checkout/data/models/ephemeral_key_model/ephemeral_key_model.dart';
import 'package:payment_integration/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment_integration/features/checkout/data/models/payment_intent_model/payment_intent_model.dart';

class StripeServices {
  // final ApiServices apiServices = ApiServices();
  // 1- create payment intent
  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    var response = await ApiServices.postData(
        url: EndPoints.paymentIntent,
        data: paymentIntentInputModel.toJson(),
        token: ApiKeys.secretKey);

    return PaymentIntentModel.fromJson(response.data);
  }

  // // --- create Customer
  // Future<PaymentIntentModel> createCustomer(
  //     PaymentIntentInputModel paymentIntentInputModel) async {
  //   var response = await ApiServices.postData(
  //       url: EndPoints.paymentIntent,
  //       data: paymentIntentInputModel.toJson(),
  //       token: ApiKeys.secretKey);

  //   return PaymentIntentModel.fromJson(response.data);
  // }

  // --- create Ephemeral_key
  Future<EphemeralKeyModel> createEphemeralkey(
      {required String customerId}) async {
    var response = await ApiServices.postData(
      url: EndPoints.ephemeralKeys,
      data: {
        'customer': customerId,
      },
      token: ApiKeys.secretKey,
      headers: {
        'Authorization': 'bearer ${ApiKeys.secretKey}',
        'Stripe-Version': '2023-10-16',
      },
    );

    return EphemeralKeyModel.fromJson(response.data);
  }
  // 2- init payment sheet

  Future initPaymentSheet(
      {required String paymentIntentClientSecret,
      required String ephemeralKeySecret}) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: paymentIntentClientSecret,
      customerEphemeralKeySecret: ephemeralKeySecret,
      customerId: ApiKeys.customerId,
      merchantDisplayName: 'elreidi',
    ));
  }

  //3- present payment sheet

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

// الفانكشن دى هتنفذلى التلت خطوات اللى فوق
  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    var ephemeralModel = await createEphemeralkey(
        customerId: paymentIntentInputModel.customerId);

    await initPaymentSheet(
        paymentIntentClientSecret: paymentIntentModel.clientSecret!,
        ephemeralKeySecret: ephemeralModel.secret!);
    await displayPaymentSheet();
  }
}
