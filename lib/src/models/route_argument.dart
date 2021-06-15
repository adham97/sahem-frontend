
import 'package:flutter/material.dart';

class RouteArgument {
  String id;
  String heroTag;
  String image;
  String description;
  String backId;
  dynamic param;
  Widget widget;
  String userId;

  RouteArgument({this.id, this.heroTag, this.image, this.description, this.backId, this.param, this.widget, this.userId});

  @override
  String toString() {
    return '{id: $id, heroTag:${heroTag.toString()}}';
  }
}
