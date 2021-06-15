import 'package:credit_card_input_form/constants/constanst.dart';
import 'package:flutter/material.dart';
import 'package:credit_card_input_form/credit_card_input_form.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/card.dart';
import '../repository/user_repository.dart';

class CardInfoWidget extends StatefulWidget {
  @override
  _CardInfoWidgetState createState() => _CardInfoWidgetState();
}

class _CardInfoWidgetState extends StateMVC<CardInfoWidget> {
  Cards card = new Cards();
  final Map<String, String> customCaptions = {
    'PREV': 'Prev',
    'NEXT': 'Next',
    'DONE': 'Done',
    'CARD_NUMBER': 'Card Number',
    'CARDHOLDER_NAME': 'Cardholder Name',
    'VALID_THRU': 'Valid Thru',
    'SECURITY_CODE_CVC': 'Security Code (CVC)',
    'NAME_SURNAME': 'Name',
    'MM_YY': 'MM/YY',
    'RESET': 'Reset',
  };

  final buttonDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(20.0),
    gradient: LinearGradient(
        colors: [
          const Color(0xffff5f01),
          const Color(0xffff6f1a),
        ],
        begin: const FractionalOffset(0.0, 0.0),
        end: const FractionalOffset(1.0, 0.0),
        stops: [0.0, 1.0],
        tileMode: TileMode.clamp),
  );

  final cardDecoration = BoxDecoration(
      boxShadow: <BoxShadow>[
        BoxShadow(color: Colors.black54, blurRadius: 15.0, offset: Offset(0, 8))
      ],
      gradient: LinearGradient(
          colors: [
            Color(0xff00325b),
            Color(0xff00325b)
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp),
      borderRadius: BorderRadius.all(Radius.circular(15)));

  final buttonTextStyle =
  TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: SafeArea(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                child: Stack(children: [
                  CreditCardInputForm(
                    showResetButton: true,
                    onStateChange: (currentState, cardInfo) {
                      if(currentState.toString() == 'InputState.DONE') {
                        var result = cardInfo.toString().split(",");
                        card.cardNumber = result[0].split("=")[1];
                        card.cardHolderName = result[1].split("=")[1];
                        card.expiryDate = result[2].split("=")[1];
                        card.cvvCode = result[3].split("=")[1];
                        card.userId = currentUser.value.id;
                        card.amount = 200;

                        Navigator.pop(context, card);
                      }
                    },
                    customCaptions: customCaptions,
                    frontCardDecoration: cardDecoration,
                    backCardDecoration: cardDecoration,
                    prevButtonDecoration: buttonDecoration,
                    nextButtonDecoration: buttonDecoration,
                    prevButtonTextStyle: buttonTextStyle,
                    nextButtonTextStyle: buttonTextStyle,
                    resetButtonTextStyle: buttonTextStyle,
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
