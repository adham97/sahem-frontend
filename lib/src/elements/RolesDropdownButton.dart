import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../models/route_argument.dart';
import '../models/roles.dart';
import '../repository/users_repository.dart' as repo;

// ignore: must_be_immutable
class RolesDropdownButton extends StatefulWidget {
  String userId;
  String roleId;
  String roleName;
  final List<Roles> roleList;
  final VoidCallback onChanged;

  RolesDropdownButton({Key key, this.userId, this.roleId, this.roleName, this.roleList, this.onChanged}) : super(key: key);

  @override
  _RolesDropdownButtonState createState() => _RolesDropdownButtonState();
}

class _RolesDropdownButtonState extends State<RolesDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      content: Container(
          //alignment: Alignment.topCenter,
          width: MediaQuery.of(context).size.width,
          height: 30,
          child: Text(
            S.of(context).change_role,
            style: Theme.of(context).textTheme.headline2,
          )
      ),
      actions: [
        Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width - 200,
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Theme.of(context).primaryColor,
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: new DropdownButton(
                value: widget.roleId,
                items: widget.roleList.map((item) {
                  return new DropdownMenuItem(
                    child: new Text(
                      item.name,
                      style: TextStyle(fontSize: 18.0, height: 1.0),
                    ),
                    value: item.id,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    widget.roleId = value;
                  });
                },
                isExpanded: true,
                hint: Text(
                    widget.roleName,
                    style: TextStyle(fontSize: 18.0, height: 1.0)
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 30),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 90,
                child:  MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
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
                  onPressed: _submit,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  color: Theme.of(context).accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    S.of(context).save,
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  void _submit() {
    widget.onChanged();
    repo.updateRole(widget.userId, widget.roleId);
    Navigator.pop(context);
  }
}