import 'package:flutter/material.dart';
import 'package:sahem/src/repository/user_repository.dart';

import '../helpers/app_config.dart' as config;
import '../models/platform.dart';
import '../models/route_argument.dart';
import '../repository/settings_repository.dart';

class PlatformGridItemWidget extends StatefulWidget {
  final String id;
  final String heroTag;
  final Platform platform;
  final VoidCallback onPressed;
  final String image;

  PlatformGridItemWidget({Key key, this.id, this.heroTag, this.platform, this.onPressed, this.image}) : super(key: key);

  @override
  _ProductGridItemWidgetState createState() => _ProductGridItemWidgetState();
}

class _ProductGridItemWidgetState extends State<PlatformGridItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        Navigator.of(context).pushNamed(
          '/PlatformDetails',
          arguments: new RouteArgument(
            id: widget.platform.id,
            heroTag: setting.value.mobileLanguage.value == Locale('en', '')
                ?  widget.platform.nameEn
                :  widget.platform.nameAr,
            description: setting.value.mobileLanguage.value == Locale('en', '')
                ?  widget.platform.descriptionEn
                :  widget.platform.descriptionAr,
            backId: widget.id,
            image: widget.image,
            userId: widget.platform.userId
          )
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.platform.userId == currentUser.value.id ? Color(0xffe6f2ff) : Theme.of(context).dividerColor,
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
                  child: Hero(
                    tag: ' ',//widget.heroTag,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(widget.image), fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Text(
                    setting.value.mobileLanguage.value == Locale('en', '')
                        ? widget.platform.nameEn
                        : widget.platform.nameAr,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}