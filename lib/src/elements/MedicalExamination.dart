import 'package:flutter/material.dart';

class MedicalExaminationWidget extends StatelessWidget {
  final String examination;

  MedicalExaminationWidget({Key key, this.examination}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      height: 160,
      width: 150,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.asset(
              'assets/img/logo.png',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsetsDirectional.only(top: 10),
              child: Text(
                examination,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
