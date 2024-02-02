class PaymentIntentInputModel {
  final String amount;
  final String currency;
  final String customerId;

  PaymentIntentInputModel(
      {required this.customerId, required this.amount, required this.currency});
  // هنعملو لى جيسون عشان هنبعت الكلاس ده وده اصلا البارميتارز هنبعنهم على شكل ريكويست والريكويست بيستقبل البيانات على هيئة ماب  وده هيبقى بوست ريكويست
  toJson() {
    return {
      'amount': "${amount}00",
      'currency': currency,
      'customer': customerId
    };
  }
}
