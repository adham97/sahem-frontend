import 'package:flutter/material.dart';
import 'package:sahem/src/pages/donation_store_details.dart';

import '../models/donation_store.dart';
import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';

class DonationList extends StatefulWidget {
  final List<DonationStore> donations;
  DonationList({Key key, this.donations}) : super(key: key);

  @override
  _DonationListState createState() => _DonationListState();
}

class _DonationListState extends State<DonationList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
        padding: EdgeInsets.symmetric(horizontal: 20),
        crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4,
        children:
        List.generate(widget.donations.length, (index) {
          return InkWell(
            highlightColor: Colors.transparent,
            splashColor: Theme.of(context).accentColor.withOpacity(0.08),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DonationStoreDetails(
                  donationStore: widget.donations.elementAt(index),
                  x: 1,
                )),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: widget.donations.elementAt(index).userId == currentUser.value.id
                    ? Color(0xffe6f2ff)
                    : Theme.of(context).dividerColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Theme.of(context).focusColor.withOpacity(0.1)),
              ),
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(widget.donations.elementAt(index).image),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Text(
                          setting.value.mobileLanguage.value == Locale('en', '')
                              ? widget.donations.elementAt(index).nameEn
                              : widget.donations.elementAt(index).nameAr,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      )
    );
  }
}
