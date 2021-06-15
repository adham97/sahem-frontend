import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/users.dart';
import '../models/roles.dart';
import '../repository/users_repository.dart' as repo;

class UsersController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  List<Users> users = <Users>[];
  List<Roles> roles = <Roles>[];
  Users user = Users();

  UsersController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForUsers();
    listenForRoles();
  }

  Future<void> listenForUsers() async {
    repo.getUsers().then((_users){
      if(_users.isNotEmpty) {
        for(var _user in _users){
          setState(() => users.add(Users.formJSON(_user)));
        }
      }
    }).catchError((e){
      print(e);
    });
  }

  Future<void> listenForRoles() async {
    repo.getRoles().then((_roles){
      if(_roles.isNotEmpty) {
        for(var _role in _roles){
          setState(() => roles.add(Roles.formJSON(_role)));
        }
      }
    }).catchError((e){
      print(e);
    });
  }

  void getUser({String id}) async {
    repo.getUser(id).then((_user){
      if(_user.userId.isNotEmpty) {
          setState(() => user = _user);
      }
    }).catchError((e){
      print(e);
    });
  }

  void updateRole({String id, String role}){
    repo.updateRole(id, role).then((value) {
      if(value.contains('success'))
        print('Update user role done');
      else
        print('Can not update user role');
    });
  }

  Future<void> refreshUsers({String id}) async {
    setState(() {
      users = <Users>[];
    });
    if(id != null)
      getUser(id: id);
  }
}
