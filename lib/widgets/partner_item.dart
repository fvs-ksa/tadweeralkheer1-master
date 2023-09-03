import 'package:flutter/material.dart';
import 'package:tadweer_alkheer/models/partner.dart';
import 'package:sizer/sizer.dart';

class PartnerItem extends StatefulWidget {
  final Partner partner;

  PartnerItem(this.partner);

  @override
  _PartnerItemState createState() => _PartnerItemState();
}

class _PartnerItemState extends State<PartnerItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      //added this video.
      child: Container(
        padding: EdgeInsets.all(8),
        height: MediaQuery.of(context).size.height * 0.20,
        child: Column(
          children: <Widget>[
            // SizedBox(height: 20),
            Expanded(
              child: FadeInImage(
                width:  400,
                height: 100,
                //placeholder appears for afew minutes while the image loads
                placeholder: AssetImage(
                    'assets/images/placeholderrrrrrr.png'),
                image: NetworkImage(widget.partner.image,),

                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/images/placeholderrrrrrr.png",
                    height: 260,
                    width: 260,
                  );
                },
                fit: BoxFit.contain,
              ),
            ),

            SizedBox(height: 20),

            Flexible(
              child: Text(widget.partner.description,
                  overflow: TextOverflow.fade,style: TextStyle(fontSize: 15.sp),),
            )
          ],
        ),
      ),
    );
  }
}
