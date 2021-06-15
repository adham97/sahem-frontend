import 'package:flutter/material.dart';
import 'package:sahem/src/repository/user_repository.dart';

import '../../generated/l10n.dart';
import '../models/route_argument.dart';
import '../repository/settings_repository.dart';

class PlatformDetailsWidget extends StatefulWidget {
  final RouteArgument routeArgument;
  PlatformDetailsWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _PlatformDetailsWidgetState createState() => _PlatformDetailsWidgetState();
}

class _PlatformDetailsWidgetState extends State<PlatformDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.routeArgument.heroTag,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 150),
            padding: EdgeInsets.only(bottom: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Container(
                          child: Image.network(
                            widget.routeArgument.image,
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.width - 120,
                            width: MediaQuery.of(context).size.width - 120,
                          ),
                        ),
                        SizedBox(height: 10),
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
                                      setting.value.mobileLanguage.value == Locale('en', '')
                                          ? widget.routeArgument.description
                                          : widget.routeArgument.description,
                                      style: Theme.of(context).textTheme.bodyText1,
                                      maxLines: 20,
                                    )
                                )
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if(currentUser.value.id != widget.routeArgument.userId)
            Positioned(
            bottom: 40,
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 150,
                    child:  MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          '/CashSupport',
                          arguments: new RouteArgument(
                            id: widget.routeArgument.id
                          )
                        );
                      },
                      padding: EdgeInsets.symmetric(vertical: 14),
                      color: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        S.of(context).cash_support,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 150,
                    child:  MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          '/MaterialSupport',
                          arguments: new RouteArgument(
                            id: widget.routeArgument.id
                          )
                        );
                      },
                      padding: EdgeInsets.symmetric(vertical: 14),
                      color: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        S.of(context).material_support,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}
