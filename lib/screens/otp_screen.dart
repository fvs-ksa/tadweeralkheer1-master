// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'dart:math';
// import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
//
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:tadweer_alkheer/screens/tabs_screen.dart';
// import '../providers/users_provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import '../models/user.dart' as TKDUser;
// import 'package:otp_text_field/otp_field.dart';
// import 'package:otp_text_field/style.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// import 'authn_screen.dart';
//
// class OtpScreen extends StatefulWidget {
//   String phone;
//
//   OtpScreen({this.phone});
//
//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }
//
// class _OtpScreenState extends State<OtpScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final _formKey = GlobalKey<FormState>();
//   OtpFieldController otpFieldController = OtpFieldController();
//   bool _isInit = true;
//   var _isLogin = true;
//   var _isDonor = true;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   var _isLoading = false;
//   String _userName = '';
//   String code = '123456';
//   int min = 100000; //min and max values act as your 6 digit range
//   int max = 999999;
//   var randomizer = new Random();
//   int verId;
//   String phone;
//   bool codeSent = false;
//   String _verificationCode;
//
// // static final smsCode='https://www.hisms.ws/api.php?send_sms&username=966551443653&password=tadwer@@Kf0551443653&numbers=$phone&sender=tadwer-khir&message=رمز تدوير الخير هو $code';
//
//   File _userImageFile;
//
//   Future<void> loginVerifyPin(var pin) async {
//     var rNum =( min + randomizer.nextInt(max - min)).toString();
//     // phoneAuthCredential  =
//     //     PhoneAuthProvider.getCredential(verificationId: verId, smsCode: pin);
//
//     try {
//       setState(() {
//         rNum = pin;
//       });
//       print(pin);
//       await FirebaseAuth.instance.signInWithCustomToken('QP2qzQI6VcN6NjdtaUx9WqqSpMU2').then((value) =>  Navigator.of(context)
//                   .push(MaterialPageRoute(builder: (context) => TabsScreen(1))));
//
//       // await FirebaseAuth.instance.signInWithPhoneNumber(phone).then((value) =>
//       //     Navigator.of(context)
//       //         .push(MaterialPageRoute(builder: (context) => TabsScreen(1))));
//
//       // await FirebaseAuth.instance.signInWithCredential(
//       //     PhoneAuthProvider.credential(verificationId: verId, smsCode: pin));
//       // final snackBar = SnackBar(content: Text("Login Success"));
//       // ScaffoldMessenger.of(context).showSnackBar(snackBar);
//      // Navigator.of(context).pop();
//     } on Exception catch (e) {
//       final snackBar = SnackBar(
//         content: Text("Incorrect OTP"),
//         backgroundColor: Theme.of(context).errorColor,
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (BuildContext context) => AuthnScreen(),
//         ),
//         (route) => false,
//       );
//     }
//   }
//
//   // verifyPhoneNumber() async {
//   //   await FirebaseAuth.instance.verifyPhoneNumber(
//   //     phoneNumber: '+96656666666',
//   //     verificationCompleted: (PhoneAuthCredential credential) async {
//   //       await FirebaseAuth.instance
//   //           .signInWithCredential(credential)
//   //           .then((value) {
//   //         if (value.user != null) {
//   //           print(value.user.uid);
//   //         }
//   //       });
//   //     },
//   //     verificationFailed: (FirebaseAuthException e) {
//   //       print(e.message.toString());
//   //     },
//   //     codeSent: (String verificationId, int resendToken) {
//   //       setState(() {
//   //         verificationId = '123456';
//   //         _verificationCode = verificationId;
//   //       });
//   //     },
//   //     codeAutoRetrievalTimeout: (String verificationId) {
//   //       setState(() {
//   //         _verificationCode = '123456';
//   //       });
//   //     },
//   //     timeout: Duration(seconds: 60),
//   //   );
//   // }
//
//   // UserCredential authResult;
//   var authResult;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: Theme.of(context).accentColor,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         title: Text(
//           'Tadweer Al Khair',
//         ),
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/splash_bg.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(children: <Widget>[
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Image.asset(
//                   'assets/images/splash_1.png',
//                   height: MediaQuery.of(context).size.height * 0.2,
//                   width: MediaQuery.of(context).size.width * 0.6,
//                   fit: BoxFit.scaleDown,
//
//                   //fit: BoxFit.cover,
//                 ),
//               ),
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     //if (!_isLogin && !codeSent) UserImagePicker(_pickedImage),
//
//                     if (!_isLogin && !codeSent)
//                       TextFormField(
//                         key: ValueKey('name'),
//                         autocorrect: true,
//                         textCapitalization: TextCapitalization.words,
//                         enableSuggestions: false,
//                         decoration: InputDecoration(
//                           labelText: AppLocalizations.of(context).name,
//                         ),
//                         validator: (value) {
//                           if (value.isEmpty || value.length < 4) {
//                             return AppLocalizations.of(context).validicnumber;
//                           }
//                           return null;
//                         },
//                         onSaved: (value) {
//                           _userName = value;
//                         },
//                       ),
//                     if (_isLogin)
//                       SizedBox(
//                         height: 50,
//                       ),
//                     // codeSent
//                     //     ?
//                     OTPTextField(
//                       length: 6,
//                       width: MediaQuery.of(context).size.width,
//                       fieldWidth: 30,
//                       controller: otpFieldController,
//                       style: TextStyle(fontSize: 20),
//                       textFieldAlignment: MainAxisAlignment.spaceAround,
//                       fieldStyle: FieldStyle.underline,
//                       onCompleted: (pin) async {
//
//                       },
//                       onChanged: (pin) {
//                         if (pin.length == 6) {
//                           print("Changed: " + pin);
//                         }
//                       },
//                     ),
//                     //     : TextFormField(
//                     //   key: ValueKey('phonenumber'),
//                     //   enableSuggestions: false,
//                     //   keyboardType: TextInputType.number,
//                     //   decoration: InputDecoration(
//                     //     labelText:
//                     //     AppLocalizations.of(context).phonenumberlabel,
//                     //     suffixIcon: Icon(
//                     //       Icons.smartphone,
//                     //     ),
//                     //   ),
//                     //   validator: (value) {
//                     //     if (value.isEmpty || value.length != 10) {
//                     //       return AppLocalizations.of(context)
//                     //           .verifyphonenum;
//                     //     }
//                     //     if (!value.startsWith('0')) {
//                     //       return AppLocalizations.of(context)
//                     //           .verifyphonenum2;
//                     //     }
//                     //     return null;
//                     //   },
//                     //   onSaved: (value) {
//                     //     phone = value.trim();
//                     //   },
//                     // ),
//                     // IntlPhoneField(
//                     //     decoration: InputDecoration(
//                     //         labelText: AppLocalizations.of(context)
//                     //             .phonenumberlabel,
//                     //         border: OutlineInputBorder(
//                     //             borderSide: BorderSide())),
//                     //     initialCountryCode: 'SA',
//                     //     onChanged: (phoneNumber) {
//                     //       setState(() {
//                     //         phone = phoneNumber.completeNumber;
//                     //       });
//                     //     },
//                     //   ),
//
//                     SizedBox(
//                       height: 12,
//                     ),
//                     if (_isLoading) CircularProgressIndicator(),
//                     if (!_isLoading)
//                       ElevatedButton(
//                         child: Text('تاكيد الرمز'),
//                         style: ElevatedButton.styleFrom(
//                           fixedSize: Size(
//                               MediaQuery.of(context).size.width * 0.6, 40.0),
//                           shape: RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.circular(12), // <-- Radius
//                           ),
//                         ),
//                         onPressed: /* phone == null ? null : */ () {loginVerifyPin('123456');},
//                       ),
//                     if (!_isLoading && _isLogin && _isDonor)
//                       // ElevatedButton(
//                       //   child: Text(AppLocalizations.of(context).newaccount),
//                       //   style: ElevatedButton.styleFrom(
//                       //     fixedSize: Size(
//                       //         MediaQuery.of(context).size.width * 0.6, 40.0),
//                       //     shape: RoundedRectangleBorder(
//                       //       borderRadius:
//                       //       BorderRadius.circular(12), // <-- Radius
//                       //     ),
//                       //   ),
//                       //   onPressed: () {
//                       //     setState(() {
//                       //       _isLogin = !_isLogin;
//                       //     });
//                       //   },
//                       // ),
//                       if (!_isLoading && !_isLogin)
//                         FlatButton(
//                           onPressed: () {
//                             setState(() {
//                               _isLogin = !_isLogin;
//                             });
//                           },
//                           child: Text(
//                             AppLocalizations.of(context).haveaccount,
//                             style: TextStyle(
//                                 fontSize: 10,
//                                 color: Theme.of(context).primaryColor),
//                           ),
//                         ),
//                     SizedBox(
//                       height: 100,
//                     ),
//                     /*
//
//                     if (!_isLoading && _isLogin)
//                       ElevatedButton(
//                         child: RichText(
//                           //textAlign: TextAlign.center,
//                           text: TextSpan(children: <TextSpan>[
//                             TextSpan(
//                               text: AppLocalizations.of(context).loginas,
//                             ),
//                             TextSpan(
//                                 text: _isDonor
//                                     ? AppLocalizations.of(context).driver
//                                     : AppLocalizations.of(context).donor,
//                                 style: TextStyle(
//                                     color: Theme.of(context).primaryColor,
//                                     fontWeight: FontWeight.bold)),
//                           ]),
//                         ),
//                         //  Text(_isDonor
//                         //     ? AppLocalizations.of(context).loginas + " " +  AppLocalizations.of(context).driver
//                         //     : AppLocalizations.of(context).loginas + " " +  AppLocalizations.of(context).donor),
//                         style: ElevatedButton.styleFrom(
//                           primary: Colors.grey,
//                           fixedSize: Size(
//                               MediaQuery.of(context).size.width * 0.5, 40.0),
//                           shape: RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.circular(12), // <-- Radius
//                           ),
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _isDonor = !_isDonor;
//                           });
//                         },
//                       ),
//                     */
//                   ],
//                 ),
//               ),
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
class CscPicker extends StatefulWidget {
  const CscPicker({Key key}) : super(key: key);

  @override
  State<CscPicker> createState() => _CscPickerState();
}

class _CscPickerState extends State<CscPicker> {
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),

      ),
      body: Column(
        children: [
          CSCPicker(
            layout: Layout.vertical,
            flagState: CountryFlag.ENABLE,
            cityDropdownLabel: 'City',
            stateDropdownLabel: 'State',
            countryDropdownLabel: 'Country',
            searchBarRadius: 30,
            dropdownDialogRadius: 30,
            onStateChanged: (value){
              setState(() {
                stateValue=value;
              });
            },
            onCountryChanged: (value){
              setState(() {
                countryValue=value;
              });
            },
            onCityChanged: (value){
              setState(() {
                cityValue=value;
              });

            },


          ),
        ],
      ),
    );
  }
}

