import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/card.dart';
import '../models/payment.dart';
import '../repository/card_repository.dart' as cardRepo;
import '../repository/payment_repository.dart' as paymentRepo;

class CashSupportController extends ControllerMVC {
  Cards card;
  List<Cards> cards = <Cards>[];
  Payment payment;
  GlobalKey<FormState> paymentFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  OverlayEntry loader;

  CashSupportController() {
    card = new Cards();
    payment = new Payment();
    listenForCards();
    loader = Helper.overlayLoader(context);
    paymentFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void insertCard(Cards card){
    cardRepo.insertCard(card).then((value) => print(value));
  }

  void insertPayment() async {
    FocusScope.of(context).unfocus();
    if (paymentFormKey.currentState.validate()) {
      paymentFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      paymentRepo.insertPayment(payment).then((value) {
        if (value == 'success') {
        }
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }

  Future<void> listenForCards() async {
    cardRepo.selectCard().then((_cards){
      if(_cards.isNotEmpty) {
        for(var card in _cards){
          setState(() => cards.add(Cards.fromJSON(card)));
        }
      }
    }).catchError((e){
      print(e);
    });
  }

  Future<void> refreshCards() async {
    setState(() {
      cards = <Cards>[];
    });
    await listenForCards();
  }
}