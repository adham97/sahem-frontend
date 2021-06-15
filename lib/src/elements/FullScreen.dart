import 'package:flutter/material.dart';

class FullScreenPage extends StatelessWidget {
  final image;
  FullScreenPage({this.image, Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover
            ),
          ),
        )
    );
  }
}