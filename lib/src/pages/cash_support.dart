import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/cash_support_controllers.dart';
import '../models/route_argument.dart';
import '../repository/user_repository.dart';

class CashSupport extends StatefulWidget {
  final RouteArgument routeArgument;

  CashSupport({Key key, this.routeArgument}) : super(key: key);

  @override
  _CashSupportState createState() => _CashSupportState();
}

class _CashSupportState extends StateMVC<CashSupport> {

  CashSupportController _con;
  _CashSupportState() : super(CashSupportController()) {
    _con = controller;
  }

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }
  
  @override
  void initState() {
    super.initState();
    _con.payment.userId = currentUser.value.id;
    _con.payment.platformId = widget.routeArgument.id;
    _con.payment.paymentMethodId = '1';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).cash_support,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _con.refreshCards,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  MaterialButton(
                    onPressed: () => Navigator.pushNamed(context, '/new-card'),
                    child: Row(
                      children: [
                        Icon(Icons.add_circle, color: Theme.of(context).accentColor),
                        SizedBox(width: 30),
                        Text(
                          'New card',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).accentColor,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                    itemCount: _con.cards.length,
                    itemBuilder: (BuildContext context, int index) {
                      var card = _con.cards[index];
                      return InkWell(
                        onTap: () {
                          _con.payment.cardId = card.id;
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                                  titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                                  title: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        S.of(context).donate_money,
                                        style: Theme.of(context).textTheme.headline2,
                                      )
                                  ),
                                  children: <Widget>[
                                    Form(
                                      key: _con.paymentFormKey,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              keyboardType: TextInputType.number,
                                              onSaved: (input) => _con.payment.price = input,
                                              validator: (input) {
                                                if(input.isEmpty)
                                                 return S.of(context).it_cannot_be_left_blank;
                                                else if(!isNumeric(input))
                                                  return 'You must enter a number';
                                                else
                                                  return null;
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Price',//S.of(context).price,
                                                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                                                contentPadding: EdgeInsets.all(12),
                                                hintText: 'Price',//S.of(context).first_name,
                                                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                                                //prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).accentColor),
                                                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 90,
                                          child:  MaterialButton(
                                            onPressed: () => Navigator.pop(context),
                                            padding: EdgeInsets.symmetric(vertical: 10),
                                            color: Color(0xffce2029),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              S.of(context).cancel,
                                              style: TextStyle(
                                                  color: Colors.white
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        SizedBox(
                                          width: 90,
                                          child:  MaterialButton(
                                            onPressed: () {
                                              print(_con.payment.price);
                                              if (_con.paymentFormKey.currentState.validate()) {
                                                _con.paymentFormKey.currentState.save();
                                                Navigator.pop(context);
                                                _con.insertPayment();
                                              }
                                              print(_con.payment.price);
                                            },
                                            padding: EdgeInsets.symmetric(vertical: 10),
                                            color: Theme.of(context).accentColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              S.of(context).conform,
                                              style: TextStyle(
                                                  color: Colors.white
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                      mainAxisAlignment: MainAxisAlignment.end,
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                );
                              });
                        },
                        child: CreditCardWidget(
                          cardNumber: card.cardNumber,
                          expiryDate: card.expiryDate,
                          cardHolderName: card.cardHolderName,
                          cvvCode: card.cvvCode,
                          showBackView: false,
                        ),
                      );
                    },
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}