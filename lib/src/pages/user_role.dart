import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/users_controller.dart';
import '../elements/RolesDropdownButton.dart';
import '../elements/CircularLoadingWidget.dart';
import '../models/route_argument.dart';
import '../repository/settings_repository.dart' as settingRepo;

// ignore: must_be_immutable
class UserRoleWidget extends StatefulWidget {
  RouteArgument routeArgument;

  UserRoleWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _UserRoleWidgetState createState() => _UserRoleWidgetState();
}

class _UserRoleWidgetState extends StateMVC<UserRoleWidget> {

  UsersController _con;
  _UserRoleWidgetState() : super(UsersController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.getUser(id: widget.routeArgument.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pushReplacementNamed('/Pages', arguments: 1),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,//Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: ValueListenableBuilder(
          valueListenable: settingRepo.setting,
          builder: (context, value, child) {
            return Text(
              S.of(context).user_role,
              style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
            );
          },
        ),
      ),
      body: _con.user == null || _con.user?.image == null
        ? CircularLoadingWidget(height: 500)
        : RefreshIndicator(
        onRefresh: _con.refreshUsers,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image.network(
                  _con.user.image,
                  fit: BoxFit.cover,
                  height: 150,
                  width: 150,
                ),
              ),
              SizedBox(height: 15),
              Text(
                '${_con.user.firstName} ${_con.user.fatherName} ${_con.user.grandfatherName} ${_con.user.lastName}',
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)],
                ),
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        size: 28,
                      ),
                      minLeadingWidth: 20,
                      title: Text(
                          S.of(context).personal_info,
                          style: Theme.of(context).textTheme.subtitle1
                      ),
                      // ignore: deprecated_member_use
                      trailing: SizedBox(
                        width: 50,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return RolesDropdownButton(
                                    userId: _con.user.userId,
                                    roleId: widget.routeArgument.heroTag,
                                    roleName: _con.user.roleName,
                                    roleList: _con.roles,
                                    onChanged: () {
                                      setState(() { });
                                    },
                                  );
                                }).then((value) => _con.refreshUsers(id: _con.user.userId));
                          },
                          child: Text(
                            S.of(context).edit,
                            style: Theme.of(context).textTheme.headline4.merge(TextStyle(letterSpacing: 1.3)),
                          ),
                        ),
                      )
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                      title: Text(
                        S.of(context).id_number,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      trailing: Text(
                        _con.user.identifyId,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                      title: Text(
                        S.of(context).email,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      trailing: Text(
                        _con.user.email,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                      title: Text(
                        S.of(context).phone,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      trailing: Text(
                        _con.user.phone,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                      title: Text(
                        S.of(context).address,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      trailing: Text(
                        '${_con.user.city} - ${_con.user.street}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                      title: Text(
                        S.of(context).user_role,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      trailing: Text(
                        '${_con.user.roleName}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
