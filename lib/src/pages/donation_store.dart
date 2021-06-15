import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/donation_store_controller.dart';
import '../elements/DonationsList.dart';
import '../elements/NotificationButton.dart';
import '../repository/donation_store_repository.dart';
import '../repository/settings_repository.dart';

class DonationStoreWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  DonationStoreWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _DonationStoreWidgetState createState() => _DonationStoreWidgetState();
}

class _DonationStoreWidgetState extends StateMVC<DonationStoreWidget> {
  DonationStoreController _con;
  _DonationStoreWidgetState() : super(DonationStoreController()) {
    _con = controller;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: ValueListenableBuilder(
          valueListenable: setting,
          builder: (context, value, child) {
            return Text(
              S.of(context).donation_store,
              style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
            );
          },
        ),
        actions: <Widget>[
          new NotificationButton(),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _con.refreshDonationStore,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  MaterialButton(
                    onPressed: () => Navigator.pushNamed(context, '/AddDonation'),
                    child: Row(
                      children: [
                        Icon(Icons.add_circle, color: Theme.of(context).accentColor),
                        SizedBox(width: 30),
                        Text(
                          S.of(context).add_donation,
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
            FutureBuilder(
              future: getDonations(),
              builder: (context, snapshot) {
                if(snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: SizedBox(height: 0)
                    ),
                  );
                } else {
                  return snapshot.hasData
                      ? DonationList(donations: snapshot.data)
                      : Center(child: new CircularProgressIndicator());
                }
              }),
          ],
        ),
      ),
    );
  }
}
