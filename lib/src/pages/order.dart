import 'package:flutter/material.dart';
import 'package:sahem/generated/l10n.dart';

import '../helpers/app_config.dart' as config;
import '../models/driver.dart';
import '../repository/settings_repository.dart';

class OrderWidget extends StatefulWidget {
  final Driver driver;
  OrderWidget({Key key, this.driver}) : super(key: key);

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: ValueListenableBuilder(
          valueListenable: setting,
          builder: (context, value, child) {
            return Text(
              '${widget.driver.name}',
              style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                width: config.App(context).appWidth(88),
                margin: EdgeInsets.only(top: 20, bottom: 20),
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
                    SizedBox(height: 30),
                    Container(
                      child: Image.network(
                        widget.driver.image,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.width - 120,
                        width: MediaQuery.of(context).size.width - 120,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'Description',
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Flexible(
                            child: Container(
                                width: MediaQuery.of(context).size.width - 60,
                                child: Text(
                                  widget.driver.description,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  maxLines: 20,
                                )
                            )
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            S.of(context).address,
                            style: Theme.of(context).textTheme.bodyText2,
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
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(Icons.location_on, color: Theme.of(context).accentColor),
                            SizedBox(width: 20),
                            Text(
                              '${widget.driver.address.city} - ${widget.driver.address.street}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        )
                    ),
                    SizedBox(height:20),
                    Row(
                      children: [
                        Text(
                          widget.driver.user.email,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),
                    SizedBox(height:10),
                    Row(
                      children: [
                        Text(
                          widget.driver.user.phone,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
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
                        S.of(context).received_order,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white
                        ),
                      ),
                      color: Theme.of(context).accentColor,
                      onPressed: () => null,
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            )
          ],
        )
      )
    );
  }
}
