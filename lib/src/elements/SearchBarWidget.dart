import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../pages/search.dart';

class SearchBarWidget extends StatelessWidget {
  // final ValueChanged onClickFilter;
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  SearchBarWidget({Key key, this.parentScaffoldKey}) : super(key: key);


  // const SearchBarWidget({Key key, this.onClickFilter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(SearchModal());
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.5),
            border: Border.all(
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(4)),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50, right: 12, left: 10),
              child: Icon(Icons.search, color: Theme.of(context).accentColor),
            ),
            Expanded(
              child: Text(
                '',//S.of(context).search_for_markets_or_products,
                maxLines: 1,
                style: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
