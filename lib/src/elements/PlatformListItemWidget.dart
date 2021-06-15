import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:sahem/src/repository/user_repository.dart';

import '../../generated/l10n.dart';
import '../models/platform.dart';
import '../models/route_argument.dart';
import '../repository/settings_repository.dart';

// ignore: must_be_immutable
class PlatformListItemWidget extends StatelessWidget {
  String heroTag;
  Platform platform;
  String image;

  PlatformListItemWidget({Key key, this.heroTag, this.platform, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/PlatformDetails',
          arguments: new RouteArgument(
            id: this.platform.id,
            heroTag: setting.value.mobileLanguage.value == Locale('en', '')
              ?  this.platform.nameEn
              :  this.platform.nameAr,
            description: setting.value.mobileLanguage.value == Locale('en', '')
                ?  this.platform.descriptionEn
                :  this.platform.descriptionAr,
            image: this.image,
            userId: this.platform.userId
          )
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: platform.userId == currentUser.value.id ? Color(0xffe6f2ff) : Theme.of(context).dividerColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Theme.of(context).focusColor.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: 'platforms',
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(
                    image: NetworkImage(
                      image
                    ),
                    fit: BoxFit.cover
                  ),
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
                          setting.value.mobileLanguage.value == Locale('en', '')
                            ? platform.nameEn
                            : platform.nameAr,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              '${DateFormat.E('${setting.value.mobileLanguage.value}').format(platform.date)} '
                              '${S.of(context).at} '
                              '${DateFormat.jm('${setting.value.mobileLanguage.value}').format(platform.date)}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
