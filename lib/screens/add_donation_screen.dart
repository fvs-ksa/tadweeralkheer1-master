import 'dart:io';
import 'dart:math';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tadweer_alkheer/locator.dart';
import 'package:tadweer_alkheer/models/category.dart';
import 'package:tadweer_alkheer/models/points.dart';
import 'package:tadweer_alkheer/providers/donations_provider.dart';
import 'package:tadweer_alkheer/providers/users_provider.dart';
import 'package:tadweer_alkheer/screens/donation_done_screen.dart';
import 'package:tadweer_alkheer/widgets/image_input.dart';
import 'package:tadweer_alkheer/widgets/video_input.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../models/donation.dart';
import '../models/points_map.dart';
import '../models/user.dart' as userModel;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../palette.dart';
import '../providers/categories_provider.dart';
import '../providers/donation_points_provider.dart';
import '../providers/locale_provider.dart';
import '../providers/map_provider.dart';
import '../widgets/location_input.dart';
import '../models/place_location.dart';
import '../models/category.dart';
import '../services/location_helper.dart';
import 'package:tadweer_alkheer/screens/authn_screen.dart';

class AddDonationScreen extends StatefulWidget {
  static const routeName = '/add-donation';
  List<dynamic>category;

  @override
  _AddDonationScreenState createState() => _AddDonationScreenState();
}

class _AddDonationScreenState extends State<AddDonationScreen> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _form = GlobalKey<FormState>();
  TextEditingController phoneController=TextEditingController();
  List<dynamic> categories = [];
  File _pickedVideo;
  File _pickedImage;
  PlaceLocation _pickedLocation;
  String _description;
  String _category;
  String _quantity = "0";
  String name;
  bool _isInit = true;
  DateTime _pickupDateTime;
  bool _isLoading = false;
  var _selectTime;
  var _selectDate;
  String validateMobile;
  String _mobile;
  int _points = 0;
  String selectVal;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      _category = ModalRoute.of(context).settings.arguments as String;
      _isInit = false;
    }
  }
  @override
  void initState() {

    super.initState();
  }

  //List<String> categories = ['Medical', 'Food', 'Education', 'Clothes'];

  // to recieve the selected image
  void _selectImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage;
    });
  }

// to receive the selected video
  void _selectVideo(File pickedVideo) {
    setState(() {
      _pickedVideo = pickedVideo;
      if (_pickedVideo == null) return;
    });
  }

  // to add donation points
  void _pointsAdded() {
    setState(() {
      _points = 100 + _points;
      return _points;
    });
  }

  // to recieve the selected location
  void _selectPlace(double lat, double lng) {
    setState(() {
      _pickedLocation = PlaceLocation(
        latitude: lat,
        longitude: lng,
      );
    });
  }

  //to select date
  Future _presentDatePicker() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now().add(Duration(days: 1)),
      lastDate: DateTime.now().add(Duration(days: 10)),
    );
    if (date == null) {
      return;
    }

    setState(() {
      _selectDate = date;
    });
  }

  Future _presentTimePicker() async {
    final initialTime = TimeOfDay(hour: 12, minute: 0);
    final time = await showTimePicker(
      context: _selectTime ?? context,
      initialTime: initialTime,
    );
    if (time == null) {
      return;
    }
    setState(() {
      _selectTime = time;
    });
  }

  Future pickDateTime(BuildContext context) async {
    await _presentDatePicker();
    if (_selectDate == null) return;

    await _presentTimePicker();
    if (_selectTime == null) return;
    setState(() {
      _pickupDateTime = DateTime(
        _selectDate.year,
        _selectDate.month,
        _selectDate.day,
        _selectTime.hour,
        _selectTime.minute,
      );
    });
  }
  List<dynamic>points=[];
  double distanceMetrs=0.0;
  double distanceMetrs2=0.0;
  Future distanceBetween(double startLat,double startLng,double endLat,double endLng)async{
    distanceMetrs= await Geolocator.distanceBetween(startLat, startLng, endLat, endLng);
  }

  Future<void> _addDonation() async {
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);

    //validate form
    final isValid = _form.currentState.validate();
    if (!isValid || _pickedLocation==null) {

      return showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "من فضلك قم باضافه كافه البيانات",
        ),
      );
    }
    distanceMetrs= await Geolocator.distanceBetween(_pickedLocation.latitude, _pickedLocation.longitude, 24.589893953039862, 46.74106076359749);
    distanceMetrs2= await Geolocator.distanceBetween(_pickedLocation.latitude, _pickedLocation.longitude, 24.77179430091221, 46.76773689327438);
    print('//////////////////////////////// $distanceMetrs');
    print('//////////////////////////////// $distanceMetrs2');
    print(_pickedLocation.longitude);
    print(_pickedLocation.latitude);
    double distanceKm=distanceMetrs/1000;
    double distanceKm2=distanceMetrs2/1000;
    print('//////////////////////////////////// $distanceKm');
    print('//////////////////////////////////// $distanceKm2');
    if(distanceKm >50.0 || distanceKm2>50.0){
      return showTopSnackBar(context, CustomSnackBar.info(message: 'عفوا تدوير الخير لا يخدم المنطقه المختاره'));
    }

    _isLoading = false;

    final user =  FirebaseAuth.instance.currentUser;


    if (user == null || user.isAnonymous) {
      //user have to login first!
      Navigator.of(context)
          .pushNamed(AuthnScreen.routeName, arguments: true)
          .then((value) => _addDonation());
      return;
    }

    setState(() {
      _isLoading = true;
    });
    //submit form
    _form.currentState.save();
    final donationsProvider =
        Provider.of<DonationsProvider>(context, listen: false);
    final pointsProvider =
    Provider.of<DonationPointsProvider>(context, listen: false);
    var userData = await _db.collection('users').doc(user.uid).get();

    try {
      // //to store image in firebase storage
      // final ref = FirebaseStorage.instance
      //     .ref()
      //     .child('donation_image')
      //     .child(user.uid + new Random().nextInt(1000000).toString() + '.jpg');
      //
      // await ref.putFile(_pickedImage).whenComplete(() => {});
      // //to get a url that can be saved anywhere
      // final imageUrl = await ref.getDownloadURL();

      var videoUrl;
      if (_pickedVideo != null) {
        //to store video in firebase storage
        // final vidRef = FirebaseStorage.instance
        //     .ref()
        //     .child('donation_video')
        //     .child(
        //         user.uid + new Random().nextInt(1000000).toString() + '.mp4');

        var metadata = SettableMetadata(contentType: 'video/mp4');
        // await vidRef.putFile(_pickedVideo, metadata).whenComplete(() => {});
        // //to get a url that can be saved anywhere
        // videoUrl = await vidRef.getDownloadURL();
      }
      //to get a human readable address
      final address = await LocationHelper.getPlaceAddress(
        _pickedLocation.latitude,
        _pickedLocation.longitude,
      );

      final location = PlaceLocation(
        latitude: _pickedLocation.latitude,
        longitude: _pickedLocation.longitude,
        address: address,
      );

      // var p = 0.017453292519943295;    // Math.PI / 180
      // var c = cos;
      // var a = 0.5 - c((lat2 - lat1) * p)/2 +
      //     c(lat1 * p) * c(lat2 * p) *
      //         (1 - c((lon2 - lon1) * p))/2;


      // return 12742 * Math.asin(Math.sqrt(a));
      Donation donation = Donation(
      //  id: _mobile.codeUnitAt(5).toString(),
          description: _description,
          category: _category,
          isRatings: false,
          isIssued: false,
          phoneNumber: user.phoneNumber,
          phoneNumberDetails: phoneController.text,
          name:userData.data()['name'] ,
          imageUrl: '',
          videoUrl: videoUrl,
          date: DateTime.now(), 
          userId: user.uid,
          pickupDateTime: _pickupDateTime,
          quantity: int.parse(_quantity),
          location: location,
          status: "Awaiting Pickup");
      DocumentReference don = await donationsProvider.addDonation(
        donation,
      );
      pointsProvider.addPoints(Point(userId: user.uid,quantity: 10,date: DateTime.now()));
      var updatedUser = userModel.Users(
          name: userData.data()['name'],
          fcmToken: fcmToken,
          joinDate: DateTime.parse(userData.data()['joinDate']),
          imageUrl: userData.data()['imageUrl'],
          videoUrl: userData.data()['videoUrl'],
          phoneNumber: userData.data()['phoneNumber'],
          itemsDonated: userData.data()['itemsDonated'] + 1);
      print(user.uid);
      print('token////////////// $fcmToken');
      usersProvider.updateUser(updatedUser, user.uid);
    } catch (error) {
      print('add donation error - $error');
    }
    Navigator.of(context).pop();
    print(user.phoneNumber);
    print(phoneController.text);
    print(user.email);
    print(userData.data()['name']);
   // print('////////////////////////////////////// ${Donation()}')
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => DonationDoneScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final categoriesProvider = Provider.of<CategoriesProvider>(context);
    final pointMapProvider=Provider.of<MapProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final currentLocale = localeProvider.locale;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        // iconTheme: IconThemeData(color:Palette.darkGreen),
       // automaticallyImplyLeading: false,
      //  backgroundColor: Colors.green[700],
        title: Text("${AppLocalizations.of(context).additem} - ${_category}",
         // style: TextStyle(color: Palette.darkGreen),
        ),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: pointMapProvider.fetchAllMapAsStream(),
        builder: (context,snap){
          if (snap.hasData) {
            print('markers');
            points = snap.data.docs
                .map((doc) => MapPoints.fromJson(doc.data(), doc.id))
                .toList();
            for (int i = 0; i < points.length; i++) {
              LatLng latlng =  LatLng(double.parse(points[i].lat),
                  double.parse(points[i].lng));
            //  Future getLocation()async{

                // distanceMetrs=  Geolocator.distanceBetween(latlng.latitude, latlng.longitude,_pickedLocation.latitude , _pickedLocation.longitude);
                // print('//////////////////////////////////////////// $distanceMetrs');
             // }


              // LatLng latlng = new LatLng(markerss[i].lat,
              //     markerss[i].lng);
              // this.loc.add(Marker(
              //   markerId: MarkerId(markerss[i].id.toString()),
              //   position: latlng,
              //   onTap: () {
              //     _selectLocation(double.parse(markerss[i].lat),
              //         double.parse(markerss[i].lng));
              //   },
              //   infoWindow: InfoWindow(title: markerss[i].name),
              //   icon: BitmapDescriptor.defaultMarkerWithHue(
              //       BitmapDescriptor.hueRed),
              // ));
            }
          } else {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          return StreamBuilder(
            stream:categoriesProvider.fetchAllCategoriesAsStream() ,
            builder: (context,snapShot){
              if(snapShot.hasData){
                categories = snapShot.data.docs
                    .map((doc) => Categoryy.fromMap(doc.data(), doc.id))
                    .toList();
                //  print(categories[0]);
              }else{
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(15),
                      child: Form(
                        key: _form,
                        child: ListView(
                          children: <Widget>[
//added these lines.

//added this row.
/*
                    Row(
                      children: [
                        ImageInput(_selectImage),
                        VideoInput(_selectVideo),
                      ],
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        AppLocalizations.of(context).pickupdatetimelabel,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => pickDateTime(context),
                      child: Text(
                        _pickupDateTime == null
                            ? AppLocalizations.of(context).selectdatetime
                            : DateFormat('dd/MM/yyyy HH:mm')
                                .format(_pickupDateTime),
                      ),
                    ),\
                  */
                            /*
                    TextFormField(
                      decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context).descriptionlabel),
                      maxLines: 2,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppLocalizations.of(context).descError;
                        }
                        if (value.length < 10) {
                          return AppLocalizations.of(context).least10CharError;
                        }
                        if (value.length > 110) {
                          return AppLocalizations.of(context).most110CharError;
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _description = value;
                      },
                    ),
                    */
/*
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 1),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context).quantitylabel),
                        style: TextStyle(fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                        validator: (value) {
                          if (value.isEmpty) {
                            return AppLocalizations.of(context).quantityError;
                          }
                          if (int.parse(value) < 1) {
                            return AppLocalizations.of(context)
                                .least1QuantityError;
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _quantity = value;
                        },
                      ),
                    ),
                    */

                            if (_category == "Custom")
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText:
                                    AppLocalizations.of(context).itemcategory),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please provide a category';
                                  }
                                  if (value.length < 2) {
                                    return 'This should be at least 2 characters';
                                  }
                                  if (value.length > 30) {
                                    return 'This should be at most 30 characters';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _category = value;
                                },
                              ),


                            LocationInput(_selectPlace),
                            SizedBox(height: 20,),
                            DropdownButtonHideUnderline(child: DropdownButton2(
                              isExpanded: true,
                              hint: Row(
                                children:  [
                                  Icon(
                                    Icons.list,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Expanded(
                                    child: Text(
                                      _category,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              // currentLocale.languageCode == 'ar'
                              // ? categories[index].arabicName
                              //     : categories[index].name
                              items: categories.map((item) => DropdownMenuItem(
                                value:currentLocale.languageCode == 'ar' ? item.arabicName:item.name,
                                child: Text(
                                  currentLocale.languageCode == 'ar' ? item.arabicName:item.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )).toList(),
                              value: selectVal,
                              onChanged: (val){
                                setState(() {
                                  selectVal=val;
                                  _category=val;
                                  print(_category);
                                });

                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios_outlined,
                              ),
                              iconSize: 14,
                              iconEnabledColor: Colors.white,
                              iconDisabledColor: Colors.grey,
                              buttonHeight: 50,
                              buttonWidth: 160,
                              buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: Colors.black26,
                                ),
                                color: Palette.darkGreen,
                              ),
                              buttonElevation: 2,
                              itemHeight: 40,
                              itemPadding: const EdgeInsets.only(left: 14, right: 14),
                              dropdownMaxHeight: 200,
                              dropdownWidth: 300,
                              dropdownPadding: null,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Palette.darkGreen,
                              ),
                              dropdownElevation: 8,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 6,
                              scrollbarAlwaysShow: true,
                              offset: const Offset(-20, 0),
                            )),
                            SizedBox(height: 20,),
                            //    Divider(thickness: 3,color: Colors.grey,height: 4,endIndent: 10,indent: 10,),
                            TextFormField(
                              controller: phoneController,
                              decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context).phonenumber),
                              style: TextStyle(fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                              ],
                              validator: (val) {
                                if (val.length != 10) {
                                  return AppLocalizations.of(context).validateMobile;
                                } else
                                  return null;
                              },
                              onSaved: (val) {
                                _mobile = val;
                              },
                            ),

                            TextFormField(
                              decoration: InputDecoration(
                                  labelText:
                                  AppLocalizations.of(context).descriptionlabel),
                              maxLines: 2,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.multiline,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (_isLoading)
                    Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  if (!_isLoading)
                    ElevatedButton(

                      onPressed: () {
                        if (_pickedLocation != null && _mobile != null) {
                          return null;
                        }
                        return _addDonation();
                      },
                      child: Text(AppLocalizations.of(context).donateitem),

                      style: ElevatedButton.styleFrom(
                        // primary: Palette.yellow,

                        fixedSize: Size(MediaQuery.of(context).size.width * 0.6, 5.0),
                        shape: RoundedRectangleBorder(

                          borderRadius: BorderRadius.circular(15), // <-- Radius
                        ),
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
/*
 /*_pickedImage == null ||
                  _pickupDateTime == null ||
                  */
                  (_pickedLocation == null && _mobile == null
                      ? null
                      : _addDonation
                      ),

 */
 //Column(
//         children: <Widget>[
//           Expanded(
//             child: Container(
//               margin: EdgeInsets.all(15),
//               child: Form(
//                 key: _form,
//                 child: ListView(
//                   children: <Widget>[
// //added these lines.
//
// //added this row.
// /*
//                     Row(
//                       children: [
//                         ImageInput(_selectImage),
//                         VideoInput(_selectVideo),
//                       ],
//                     ),
//
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Center(
//                       child: Text(
//                         AppLocalizations.of(context).pickupdatetimelabel,
//                         style: TextStyle(
//                             fontSize: 15,
//                             color: Colors.green[700],
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () => pickDateTime(context),
//                       child: Text(
//                         _pickupDateTime == null
//                             ? AppLocalizations.of(context).selectdatetime
//                             : DateFormat('dd/MM/yyyy HH:mm')
//                                 .format(_pickupDateTime),
//                       ),
//                     ),\
//                   */
//                     /*
//                     TextFormField(
//                       decoration: InputDecoration(
//                           labelText:
//                               AppLocalizations.of(context).descriptionlabel),
//                       maxLines: 2,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                       keyboardType: TextInputType.multiline,
//                       validator: (value) {
//                         if (value.isEmpty) {
//                           return AppLocalizations.of(context).descError;
//                         }
//                         if (value.length < 10) {
//                           return AppLocalizations.of(context).least10CharError;
//                         }
//                         if (value.length > 110) {
//                           return AppLocalizations.of(context).most110CharError;
//                         }
//                         return null;
//                       },
//                       onSaved: (value) {
//                         _description = value;
//                       },
//                     ),
//                     */
// /*
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 20, horizontal: 1),
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                             labelText:
//                                 AppLocalizations.of(context).quantitylabel),
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                         keyboardType: TextInputType.phone,
//                         inputFormatters: [
//                           FilteringTextInputFormatter.allow(RegExp('[0-9]')),
//                         ],
//                         validator: (value) {
//                           if (value.isEmpty) {
//                             return AppLocalizations.of(context).quantityError;
//                           }
//                           if (int.parse(value) < 1) {
//                             return AppLocalizations.of(context)
//                                 .least1QuantityError;
//                           }
//                           return null;
//                         },
//                         onSaved: (value) {
//                           _quantity = value;
//                         },
//                       ),
//                     ),
//                     */
//
//                     if (_category == "Custom")
//                       TextFormField(
//                         decoration: InputDecoration(
//                             labelText:
//                                 AppLocalizations.of(context).itemcategory),
//                         keyboardType: TextInputType.text,
//                         validator: (value) {
//                           if (value.isEmpty) {
//                             return 'Please provide a category';
//                           }
//                           if (value.length < 2) {
//                             return 'This should be at least 2 characters';
//                           }
//                           if (value.length > 30) {
//                             return 'This should be at most 30 characters';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) {
//                           _category = value;
//                         },
//                       ),
//
//
//                     LocationInput(_selectPlace),
//
//                     TextFormField(
//                       controller: phoneController,
//                       decoration: InputDecoration(
//                           labelText: AppLocalizations.of(context).phonenumber),
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                       keyboardType: TextInputType.phone,
//                       inputFormatters: [
//                         FilteringTextInputFormatter.allow(RegExp('[0-9]')),
//                       ],
//                       validator: (val) {
//                         if (val.length != 10) {
//                           return AppLocalizations.of(context).validateMobile;
//                         } else
//                           return null;
//                       },
//                       onSaved: (val) {
//                         _mobile = val;
//                       },
//                     ),
//
//                     TextFormField(
//                       decoration: InputDecoration(
//                           labelText:
//                               AppLocalizations.of(context).descriptionlabel),
//                       maxLines: 2,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                       keyboardType: TextInputType.multiline,
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           if (_isLoading)
//             Center(
//               child: CircularProgressIndicator.adaptive(),
//             ),
//           if (!_isLoading)
//             ElevatedButton(
//
//               onPressed: () {
//                 if (_pickedLocation != null && _mobile != null) {
//                   return null;
//                 }
//                   return _addDonation();
//               },
//               child: Text(AppLocalizations.of(context).donateitem),
//
//               style: ElevatedButton.styleFrom(
//                 // primary: Palette.yellow,
//
//                 fixedSize: Size(MediaQuery.of(context).size.width * 0.6, 5.0),
//                 shape: RoundedRectangleBorder(
//
//                   borderRadius: BorderRadius.circular(15), // <-- Radius
//                 ),
//               ),
//             ),
//         ],
//       )
