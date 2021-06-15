class Cards {
  String id;
  String userId;
  String cardNumber;
  String expiryDate;
  String cardHolderName;
  String cvvCode;
  int amount;

  Cards();

  Cards.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['card_id'];
      userId = jsonMap['user_id'];
      cardNumber = jsonMap['card_number'];
      expiryDate = jsonMap['expiry_date'];
      cardHolderName = jsonMap['card_holder_name'];
      cvvCode = jsonMap['cvv_code'];
      amount = int.parse(jsonMap['amount']);
    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['user_id'] = userId;
    map["card_number"] = cardNumber;
    map["expiry_date"] = expiryDate;
    map["card_holder_name"] = cardHolderName;
    map["cvv_code"] = cvvCode;
    map["amount"] = amount;
    return map;
  }

  bool isCompleteCardInfo(){
    return this.cardNumber != null && this.cardHolderName != null && this.expiryDate != null && this.cvvCode != null;
  }
}