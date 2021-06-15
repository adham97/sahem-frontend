import 'package:flutter/material.dart';
import 'package:sahem/src/pages/donation_store_details.dart';

import '../models/route_argument.dart';
import '../repository/settings_repository.dart';
import '../models/search.dart';

class SearchList extends StatefulWidget {
  final List<Search> result;
  SearchList({Key key, this.result}) : super(key: key);

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.result.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            final item = widget.result[index];
            return GestureDetector(
              onTap: () {
                if(item.platform != null) {
                  Navigator.of(context).pushNamed(
                      '/PlatformDetails',
                      arguments: new RouteArgument(
                        id: item.platform.id,
                        heroTag: setting.value.mobileLanguage.value == Locale('en', '')
                            ?  item.platform.nameEn
                            :  item.platform.nameAr,
                        description: setting.value.mobileLanguage.value == Locale('en', '')
                            ?  item.platform.descriptionEn
                            :  item.platform.descriptionAr,
                        image: item.image,
                        userId: item.platform.userId
                      )
                  );
                }

                if(item.donationStore != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DonationStoreDetails(
                      donationStore: item.donationStore,
                      x: 2,
                    )),
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: item.platform.id != null
                    ? Row(
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
                                    RichText(
                                      text: TextSpan(
                                        style: new TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black87,
                                        ),
                                        children: <TextSpan>[
                                          new TextSpan(
                                            text: setting.value.mobileLanguage.value == Locale('en', '')
                                              ?  item.platform.nameEn
                                              :  item.platform.nameAr,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            image: DecorationImage(
                                image: NetworkImage(item.donationStore.image),
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
                                    RichText(
                                      text: TextSpan(
                                        style: new TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black87,
                                        ),
                                        children: <TextSpan>[
                                          // if(item.notificationTypeId == '1')
                                          //   new TextSpan(
                                          //       text: '${S.of(context).sahem} ',
                                          //       style: new TextStyle(fontWeight: FontWeight.w500)
                                          //   ),
                                          new TextSpan(text: item.donationStore.nameEn),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
              ),
            );
          }
      )
    );
  }
}
