import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../models/user.dart';

class SupportDialog extends StatefulWidget {
  final VoidCallback onChanged;

  SupportDialog({Key key, this.onChanged}) : super(key: key);

  @override
  _SupportDialogDialogState createState() => _SupportDialogDialogState();
}

class _SupportDialogDialogState extends State<SupportDialog> {
  GlobalKey<FormState> _profileSettingsFormKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return FlatButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              title: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  S.of(context).offer_support,
                  style: Theme.of(context).textTheme.headline2,
                )
              ),
              children: <Widget>[
                Column(
                  children: [
                    SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 200,
                      child:  MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/CashSupport');
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
                      width: MediaQuery.of(context).size.width - 200,
                      child:  MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/MaterialSupport');
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
                SizedBox(height: 20),
                Row(
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
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
                SizedBox(height: 20),
              ],
            );
          });
      },
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 14),
      color: Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: Theme.of(context).accentColor,)
      ),
      height: 45,
      child: Text(
        S.of(context).offer_support,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 18 ,color: Colors.white),
      ),
    );
  }

  InputDecoration getInputDecoration({String hintText, String labelText}) {
    return new InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: Theme.of(context).textTheme.bodyText2.merge(
        TextStyle(color: Theme.of(context).focusColor),
      ),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor.withOpacity(0.2))),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor)),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      labelStyle: Theme.of(context).textTheme.bodyText2.merge(
        TextStyle(color: Theme.of(context).hintColor),
      ),
    );
  }

  void _submit() {
    if (_profileSettingsFormKey.currentState.validate()) {
      _profileSettingsFormKey.currentState.save();
      widget.onChanged();
      Navigator.pop(context);
    }
  }
}
