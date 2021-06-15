class Payment {
  String paymentId;
  String price;
  String cardId;
  String description;
  String addressId;
  String userId;
  String status;
  String paymentMethodId;
  String platformId;

  Payment();

  Payment.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      paymentId = jsonMap['payment_id'];
      price = jsonMap['price'];
      cardId = jsonMap['card_id'];
      description = jsonMap['description'];
      addressId = jsonMap['address_id'];
      userId = jsonMap['user_id'];
      status = jsonMap['status'];
      paymentMethodId = jsonMap['payment_method_id'];
      platformId = jsonMap['platform_id'];
    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["price"] = price;
    map["card_id"] = cardId;
    map["description"] = description;
    map["address_id"] = addressId;
    map["user_id"] = userId;
    map["status"] = status;
    map["payment_method_id"] = paymentMethodId;
    map["platform_id"] = platformId;
    return map;
  }
}