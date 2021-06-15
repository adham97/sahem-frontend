import 'package:flutter/material.dart';

import '../models/platform_categories.dart';
import '../models/route_argument.dart';
import '../elements/PlatformCategoryItemWidget.dart';
import '../elements/PlatformCategoryLoaderWidget.dart';
import '../repository/settings_repository.dart';

// ignore: must_be_immutable
class PlatformCategoriesWidget extends StatefulWidget {
  List<PlatformCategories> platformCategoryList;

  PlatformCategoriesWidget({Key key, this.platformCategoryList}) : super(key: key);

  @override
  _PlatformCategoriesWidgetState createState() => _PlatformCategoriesWidgetState();
}

class _PlatformCategoriesWidgetState extends State<PlatformCategoriesWidget> {

  @override
  Widget build(BuildContext context) {
    return widget.platformCategoryList.isEmpty
    ? PlatformCategoryLoaderWidget()
    : Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.platformCategoryList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                '/Platform',
                arguments: RouteArgument(
                  id: widget.platformCategoryList.elementAt(index).id,
                  heroTag: setting.value.mobileLanguage.value == Locale('en', '')
                    ? widget.platformCategoryList.elementAt(index).nameEn
                    : widget.platformCategoryList.elementAt(index).nameAr,
                  image: widget.platformCategoryList.elementAt(index).image
                ),
              );
            },
            child: PlatformCategoryWidget(
                platformCategories: widget.platformCategoryList.elementAt(index),
            ),
          );
        },
      ),
    );
  }
}
