import 'package:flutter/material.dart';
import 'package:tadweer_alkheer/palette.dart';

Widget textCard(
    {@required BuildContext context,
    @required double width,
    @required String text,
    @required TextAlign align}) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),

    elevation: 4,
    margin: EdgeInsets.all(12),
    //The green box..

    child: Container(
      //color: Theme.of(context).primaryColor,
      width: width,
      padding:
          EdgeInsetsDirectional.only(bottom: 5, top: 10, start: 17, end: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Palette.darkGreen),
      child: Text(
        text,
        textAlign: align,
        style: TextStyle(color: Colors.white,),
      ),
    ),
  );
}
