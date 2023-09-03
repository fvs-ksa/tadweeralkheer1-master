import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../palette.dart';

Widget contactContainer({
  Function fct,
  String label,
  IconData iconData,
}) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: InkWell(
      onTap: () {
        fct();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
            color: Palette.darkGreen, borderRadius: BorderRadius.circular(15)),
        clipBehavior: Clip.antiAlias,
        // color: Colors.green[100],
        child: Row(
          children: [
            Icon(
              iconData,
              color: Colors.white,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              label,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    ),
  );
}

showAlert({BuildContext context, String call, String sms, String whatsapp}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 8.0,
        contentPadding: EdgeInsets.all(18.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        content: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () => launch('tel:+966535381868'),
                child: Container(
                  height: 50.0,
                  alignment: Alignment.center,
                  child: Text(call),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () => launch('sms:+966535381868'),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Text(sms),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () => launch('https://wa.me/+966535381868'),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Text(whatsapp),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
