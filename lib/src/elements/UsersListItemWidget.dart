import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/users.dart';
import '../models/route_argument.dart';
import 'PlatformCategoryLoaderWidget.dart';
import 'SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight.dart';

// ignore: must_be_immutable
class UsersListItemWidget extends StatefulWidget {
  List<Users> usersList;

  UsersListItemWidget({Key key, this.usersList}) : super(key: key);

  @override
  _UsersListItemWidgetState createState() => _UsersListItemWidgetState();
}

class _UsersListItemWidgetState extends State<UsersListItemWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.usersList.isEmpty
        ? CircularProgressIndicator()
        : Container(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: widget.usersList.length,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(15),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                crossAxisCount: 1,
                crossAxisSpacing: 1,
                mainAxisSpacing: 10,
                height: 90.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                final item = widget.usersList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/UserRole',
                        arguments: RouteArgument(
                          id: item.userId,
                          heroTag: item.roleId,
                          description: item.roleName
                        )
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).dividerColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Theme.of(context).focusColor.withOpacity(0.1)),
                      boxShadow: [
                        BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            image: DecorationImage(
                                image: NetworkImage(item.image),
                                fit: BoxFit.cover
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 10),
                                    Text(
                                      '${item.firstName} ${item.lastName}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: Theme.of(context).textTheme.subtitle1,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '${item.roleName}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: Theme.of(context).textTheme.subtitle2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        );
  }
}

/*
return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Platforms',
                        arguments: RouteArgument(
                          id: widget.usersList.elementAt(index).userId,
                        )
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.9),
                      boxShadow: [
                        BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            image: DecorationImage(
                                image: NetworkImage(widget.usersList.elementAt(index).image),
                                fit: BoxFit.cover
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${widget.usersList.elementAt(index).firstName} ${widget.usersList.elementAt(index).lastName}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8),
                              //Helper.getPrice(product.price, context, style: Theme.of(context).textTheme.headline6),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
                */