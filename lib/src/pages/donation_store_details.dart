import 'dart:async';

import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import 'package:sahem/src/models/donation_store.dart';
import 'package:sahem/src/repository/donation_store_repository.dart';
import 'package:sahem/src/repository/settings_repository.dart';
import 'package:sahem/src/repository/user_repository.dart';

class DonationStoreDetails extends StatefulWidget {
  DonationStore donationStore;
  final int x;
  DonationStoreDetails({Key key, this.donationStore, this.x}) : super(key: key);

  @override
  _DonationStoreDetailsState createState() => _DonationStoreDetailsState();
}

class _DonationStoreDetailsState extends State<DonationStoreDetails> {
  GlobalKey<ScaffoldState> scaffoldKey;

  @override
  void initState() {
    super.initState();
    scaffoldKey = new GlobalKey<ScaffoldState>();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
          onPressed: () {
            widget.x == 1
              ? Navigator.of(context).pushReplacementNamed('/Pages', arguments: 0)
              : Navigator.of(context).pushReplacementNamed('/Pages', arguments: 4);
          },
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: ValueListenableBuilder(
          valueListenable: setting,
          builder: (context, value, child) {
            return Text(
              setting.value.mobileLanguage.value == Locale('en', '')
                  ? '${widget.donationStore.nameEn}'
                  : '${widget.donationStore.nameAr}',
              style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
            );
          },
        ),
      ),
      body:  SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Image.network(
                  widget.donationStore.image,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width - 60,
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Flexible(
                      child: Text(setting.value.mobileLanguage.value == Locale('en', '')
                          ? widget.donationStore.descriptionEn != null
                          ? widget.donationStore.descriptionEn
                          : ''
                          : widget.donationStore.descriptionAr != null
                          ? widget.donationStore.descriptionAr
                          : '',
                        style: Theme.of(context).textTheme.subtitle1,
                        maxLines: 20,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ),
      bottomNavigationBar: (widget.donationStore.userId != currentUser.value.id)
          ? Container(
            padding: EdgeInsets.only(left: 25, right: 25, bottom: 20, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 60,
                  child: MaterialButton(
                    onPressed: () {
                      idNeedDonation(widget.donationStore.id).then((value) {
                        if(value == 'success') {
                          scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text(S.of(context).you_will_receive_it),
                          ));
                        }
                      }).whenComplete(() {
                        new Timer(const Duration(milliseconds: 400), () {
                          Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 0);
                        });
                      });
                    },
                    padding: EdgeInsets.symmetric(vertical: 14),
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      S.of(context).i_need_it,
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
          : SizedBox(height: 0),
    );
  }
}
