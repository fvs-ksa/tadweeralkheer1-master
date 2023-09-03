import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tadweer_alkheer/palette.dart';
import 'package:tadweer_alkheer/screens/tabs_screen.dart';

import 'authn_screen.dart';
import 'package:sizer/sizer.dart';

class BoardingModel {
  String image;
  String logo;

  BoardingModel({this.image, this.logo});
}

class OnBoardingScreen extends StatefulWidget {
  // const MyApp({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController=PageController();
  List<BoardingModel> boarding = [
    BoardingModel(
      logo: 'assets/images/logodown.png',
      image: 'assets/images/step 1-.png',
    ),
    BoardingModel(
      logo: 'assets/images/logodown.png',
      image: 'assets/images/step 2.png',
    ),
    BoardingModel(
      logo: 'assets/images/logodown.png',
      image: 'assets/images/step 3.png',
    ),
  ];
  bool isLast=false;
 // Material materialButton;
  int index;

  Widget buildOnBoardingItem(BoardingModel model) {
    return SizerUtil.orientation == Orientation.portrait?  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 15.h,),
        Image(image: AssetImage(model.logo,),height: 25.h,width: 40.w,),
        // SizedBox(height: 25,),
        Image(image: AssetImage(model.image,),height: 40.h,width: 60.w,),
      ],
    ):Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // SizedBox(height: 35,),
        Image(image: AssetImage(model.logo,),height: 11.h,width: 35.w,),
        // SizedBox(height: 25,),
        Image(image: AssetImage(model.image,),height: 23.h,width: 60.w,),
      ],
    );
  }
  // final onboardingPagesList = [
  //   PageModel(
  //     widget: SingleChildScrollView(
  //       controller: ScrollController(),
  //       child: Column(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.symmetric(
  //               horizontal: 45.0,
  //               vertical: 90.0,
  //             ),
  //             child: Image.asset(
  //               'assets/images/onboarding1.png',
  //             ),
  //           ),
  //
  //         ],
  //       ),
  //     ),
  //   ),
  //   PageModel(
  //     widget: SingleChildScrollView(
  //       controller: ScrollController(),
  //       child: Column(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.symmetric(
  //               horizontal: 45.0,
  //               vertical: 90.0,
  //             ),
  //             child: Image.asset(
  //               'assets/images/onboarding2.png',
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ),
  //   PageModel(
  //     widget: SingleChildScrollView(
  //       controller: ScrollController(),
  //       child: Column(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.symmetric(
  //               horizontal: 45.0,
  //               vertical: 90.0,
  //             ),
  //             child: Image.asset(
  //               'assets/images/onboarding3.png',
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ),
  // ];

  @override
  void initState() {
    super.initState();
    index = 0;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: 2.h,horizontal: 5.w),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  if(index==boarding.length -1){
                    print('last');
                    setState(() {
                      isLast=true;
                    });
                  }else{
                    setState(() {
                      isLast=false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) {
                  return buildOnBoardingItem(boarding[index]);
                },
                itemCount: boarding.length,
              ),
            ),
            Row(children: [
             SmoothPageIndicator(controller: boardController,
               count: boarding.length,effect: ExpandingDotsEffect(
               dotColor: Colors.grey,
               activeDotColor: Palette.darkGreen,
               dotWidth: 10,
               dotHeight: 10,
               expansionFactor: 4,
               spacing: 5
             ),),
              Spacer(),
              FloatingActionButton(onPressed: (){
                if(isLast){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> TabsScreen(1))
                   ,
                   // AuthnScreen.routeName,

                  );
                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthnScreen()));
                }else{

                  boardController.nextPage(duration: Duration(milliseconds: 750), curve: Curves.fastLinearToSlowEaseIn);
                }

              },child:isLast?Icon(Icons.check): Icon(
                Icons.arrow_forward_ios
              ),)
            ],)
            // SizedBox(
            //   height: 20,
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            //   child: Row(
            //     children: [_skipButton(), Spacer(), Icon(Icons.share)],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
