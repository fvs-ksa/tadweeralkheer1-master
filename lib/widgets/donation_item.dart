import 'package:flutter/material.dart';
import 'package:tadweer_alkheer/models/donation.dart';
import 'package:tadweer_alkheer/models/issue.dart';
import 'package:tadweer_alkheer/screens/donation_details_screen.dart';

class DonationItem extends StatefulWidget {
  final Donation donation;
  final String description;

  DonationItem({this.donation,this.description});
  @override
  _DonationItemState createState() => _DonationItemState();
}

class _DonationItemState extends State<DonationItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(

        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => DonationDetailsScreen(widget.donation),
          ));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          //added this video.
          child: Container(
            padding: EdgeInsets.all(8),
            height: MediaQuery.of(context).size.height * 0.12,
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage(
                      //placeholder appears for afew minutes while the image loads
                      placeholder: AssetImage('assets/images/logo.png'),
                      image: NetworkImage(widget.donation.imageUrl),

                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/images/logo.png",
                          height: 260,
                          width: 260,
                        );
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Text(widget.description,
                      style: TextStyle(color: Colors.black),
                      overflow: TextOverflow.ellipsis),
                )
              ],
            ),
          ),
        ));
  }
}
