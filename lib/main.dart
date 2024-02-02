import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_integration/core/helper/api_services.dart';
import 'package:payment_integration/core/observer/bloc_observer.dart';
import 'package:payment_integration/core/utils/constants/api_keys.dart';
import 'package:payment_integration/features/checkout/presentation/views/cart_view/my_cart_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await ApiServices.init();
  Stripe.publishableKey = ApiKeys.publishableKey;
  runApp(const CheckoutApp());
}

class CheckoutApp extends StatelessWidget {
  const CheckoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCartView(),
    );
  }
}

// Future<void> initPaymentSheet() async {
//     try {

//       // 2. initialize the payment sheet
//      await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           // Main params
//           merchantDisplayName: 'Flutter Stripe Store Demo',
//           //  create payment intent ده بيجى من
//           paymentIntentClientSecret: data['paymentIntent'],

//         ),
//       );
//       setState(() {
//         _ready = true;
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//       rethrow;
//     }
// }
