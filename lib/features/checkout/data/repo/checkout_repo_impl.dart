import 'package:dartz/dartz.dart';
import 'package:payment_integration/core/errors/failure.dart';
import 'package:payment_integration/core/helper/stripe_services.dart';
import 'package:payment_integration/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment_integration/features/checkout/data/repo/checkout_repo.dart';

class CheckoutRepoImpl extends CheckoutRepo {
  final StripeServices stripeService = StripeServices();
  @override
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      await stripeService.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);
      return right(null);
    } on Exception catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
