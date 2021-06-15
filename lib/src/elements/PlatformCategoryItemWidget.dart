import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/platform_categories.dart';
import '../repository/settings_repository.dart';

// ignore: must_be_immutable
class PlatformCategoryWidget extends StatelessWidget {
  PlatformCategories platformCategories;

  PlatformCategoryWidget({Key key, this.platformCategories}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Theme.of(context).focusColor.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).focusColor.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 5)
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: FadeInImage.assetNetwork(
              height: MediaQuery.of(context).size.width / 2,
              width: double.infinity,
              image: platformCategories.image,
              placeholder: 'assets/img/loading.gif',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  setting.value.mobileLanguage.value == Locale('en', '')
                    ? platformCategories.nameEn
                    : platformCategories.nameAr,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: Theme.of(context).textTheme.headline5,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
