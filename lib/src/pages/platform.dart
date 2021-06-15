import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controllers/platform_controller.dart';
import '../elements/PlatformGridItemWidget.dart';
import '../elements/PlatformListItemWidget.dart';
import '../elements/CircularLoadingWidget.dart';
import '../models/route_argument.dart';

class PlatformWidget extends StatefulWidget {
  final RouteArgument routeArgument;

  PlatformWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _PlatformWidgetState createState() => _PlatformWidgetState();
}

class _PlatformWidgetState extends StateMVC<PlatformWidget> {
  // TODO add layout in configuration file
  String layout = 'grid';

  PlatformController _con;

  _PlatformWidgetState() : super(PlatformController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForCategory(id: widget.routeArgument.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.routeArgument.heroTag,//_con.?.name ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        ),
        actions: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  setState(() {
                    this.layout = 'list';
                  });
                },
                icon: Icon(
                  Icons.format_list_bulleted,
                  color: this.layout == 'list' ? Theme.of(context).accentColor : Theme.of(context).focusColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    this.layout = 'grid';
                  });
                },
                icon: Icon(
                  Icons.apps,
                  color: this.layout == 'grid' ? Theme.of(context).accentColor : Theme.of(context).focusColor,
                ),
              )
            ],
          ),
         ],
      ),
      body: RefreshIndicator(
        onRefresh: _con.refreshCategory,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _con.platforms.isEmpty
              ? CircularLoadingWidget(height: 500)
              : Offstage(
                offstage: this.layout != 'list',
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: _con.platforms.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    return PlatformListItemWidget(
                      heroTag: 'favorites_list',
                      platform: _con.platforms.elementAt(index),
                      image: widget.routeArgument.image
                    );
                  },
                ),
              ),
              _con.platforms.isEmpty
              ? CircularLoadingWidget(height: 500)
              : Offstage(
                offstage: this.layout != 'grid',
                child: GridView.count(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4,
                  // Generate 100 widgets that display their index in the List.
                  children:
                  List.generate(_con.platforms.length, (index) {
                    return PlatformGridItemWidget(
                      id: widget.routeArgument.id,
                      heroTag: 'category_grid',
                      platform: _con.platforms.elementAt(index),
                      image: widget.routeArgument.image,
                        /*
                        onPressed: () {
                          if (currentUser.value.token == null) {
                            Navigator.of(context).pushNamed('/Login');
                          } else {
                            if (_con.isSameMarkets(_con.products.elementAt(index))) {
                              _con.addToCart(_con.products.elementAt(index));
                            } else {
                              /*
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  /*
                                  // return object of type Dialog
                                  return AddToCartAlertDialogWidget(
                                      oldProduct: _con.carts.elementAt(0)?.product,
                                      newProduct: _con.products.elementAt(index),
                                      onPressed: (product, {reset: true}) {
                                        return _con.addToCart(_con.products.elementAt(index), reset: true);
                                      });
                                  */
                                },
                              );
                              */
                            }
                          }
                        }*/
                        );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
