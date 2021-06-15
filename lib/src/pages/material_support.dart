import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/material_support_controllers.dart';
import '../helpers/app_config.dart' as config;
import '../models/route_argument.dart';
import '../repository/user_repository.dart';

class MaterialSupport extends StatefulWidget {
  final RouteArgument routeArgument;

  MaterialSupport({Key key, this.routeArgument}) : super(key: key);

  @override
  _MaterialSupportState createState() => _MaterialSupportState();
}

class _MaterialSupportState extends StateMVC<MaterialSupport> {
  MaterialSupportController _con;
  _MaterialSupportState() : super(MaterialSupportController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    _con.payment.userId = currentUser.value.id;
    _con.payment.platformId = widget.routeArgument.id;
    _con.payment.paymentMethodId = '2';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).material_support,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              width: config.App(context).appWidth(88),
              margin: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Theme.of(context).hintColor.withOpacity(0.2),
                    )
                  ]
              ),
              child: Column(
                children: [
                  Form(
                    key: _con.paymentFormKey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                S.of(context).package_description,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            )
                          ],
                        ),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          minLines: 5,
                          maxLines: 5,
                          onSaved: (input) => input.isNotEmpty ? _con.payment.description = input : null,
                          validator: (input) => input.isEmpty ? S.of(context).it_cannot_be_left_blank : null,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Theme.of(context).accentColor),
                            contentPadding: EdgeInsets.all(12),
                            hintText: S.of(context).package_description,
                            hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                            //prefixIcon: Icon(Icons.email_outlined, color: Theme.of(context).accentColor),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          S.of(context).address,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      )
                    ],
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width - 60,
                      height: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: Theme.of(context).focusColor.withOpacity(0.5)),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              color: Theme.of(context).hintColor.withOpacity(0.2),
                            )
                          ]
                      ),
                      child: MaterialButton(
                          onPressed: () {
                            _con.insertAddress();
                          },
                          child: Row(
                            children: [
                              Icon(Icons.location_on, color: Theme.of(context).accentColor),
                              SizedBox(width: 20),
                              Text(
                                _con.address.latitude.toString() != '0'
                                    ? '${currentUser.value.city}, ${currentUser.value.street}'
                                    : 'New address',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          )
                      )
                  ),
                  SizedBox(height: 30),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(color: Theme.of(context).accentColor,)
                    ),
                    height: 45,
                    minWidth: MediaQuery.of(context).size.width - 60,
                    child: Text(
                      S.of(context).submit,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                      ),
                    ),
                    color: Theme.of(context).accentColor,
                    onPressed: () => _con.insertPayment(),
                  ),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
