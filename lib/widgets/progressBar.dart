import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProgressBar extends StatefulWidget {
  String status;
  ProgressBar({Key key,this.status}) : super(key: key);

  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(milliseconds: 8800),
      vsync: this,
    );
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBar(
      controller: animationController,
      text: widget.status,

    );
  }
}
// Awaiting Pickup
// Awaiting Deliver
// delivered


class AnimatedBar extends StatelessWidget {
  final dotSize = 20.0;
String text;
  AnimatedBar({Key key, this.controller,this.text})
      : dotOneColor = ColorTween(
          begin: Colors.grey,
          end: Colors.green,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.000,
              0.100,
              curve: Curves.linear,
            ),
          ),
        ),
        textOneStyle = TextStyleTween(
          begin: TextStyle(
              fontWeight: FontWeight.w400, color: Colors.grey, fontSize: 12),
          end: TextStyle(
              fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 12),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.000,
              0.100,
              curve: Curves.linear,
            ),
          ),
        ),
        progressBarOne = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,

            curve: Interval(0.100, 0.450),
          ),
        ),
        dotTwoColor = ColorTween(
          begin: Colors.grey,
          end: Colors.green,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.450,
              0.550,
              curve: Curves.linear,
            ),
          ),
        ),
        textTwoStyle = TextStyleTween(
          begin: TextStyle(
              fontWeight: FontWeight.w400, color: Colors.grey, fontSize: 12),
          end: TextStyle(
              fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 12),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.450,
              0.550,
              curve: Curves.linear,
            ),
          ),
        ),
        progressBarTwo = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.550, 0.900),
          ),
        ),
        dotThreeColor = ColorTween(
          begin: Colors.grey,
          end: Colors.green,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.900,
              1.000,
              curve: Curves.linear,
            ),
          ),
        ),
        textThreeStyle = TextStyleTween(
          begin: TextStyle(
              fontWeight: FontWeight.w400, color: Colors.grey, fontSize: 12),
          end: TextStyle(
              fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 12),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.900,
              1.000,
              curve: Curves.linear,
            ),
          ),
        ),
        super(key: key);

  final AnimationController controller;
  final Animation<Color> dotOneColor;
  final Animation<TextStyle> textOneStyle;
  final Animation<double> progressBarOne;
  final Animation<Color> dotTwoColor;
  final Animation<TextStyle> textTwoStyle;
  final Animation<double> progressBarTwo;
  final Animation<Color> dotThreeColor;
  final Animation<TextStyle> textThreeStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Text('${(controller.value * 100.0).toStringAsFixed(1)}%'),
                  Container(
                    width: dotSize,
                    height: dotSize,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(dotSize / 2),
                        color: dotOneColor.value),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 2,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.grey,
                        value: progressBarOne.value,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: dotSize,
                    height: dotSize,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(dotSize / 2),
                        color: dotTwoColor.value),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 2,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.grey,
                        value: progressBarTwo.value,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: dotSize,
                    height: dotSize,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(dotSize / 2),
                        color: dotThreeColor.value),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              width: MediaQuery.of(context).size.width / 1.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).ready,
                    style: textOneStyle.value,
                  ),
                  Center(
                    child: Text(
                      AppLocalizations.of(context).preparing,
                      style: textTwoStyle.value,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).received,
                    style: textThreeStyle.value,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
