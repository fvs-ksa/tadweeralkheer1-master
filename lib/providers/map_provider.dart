import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tadweer_alkheer/services/crud_model.dart';
import 'package:location/location.dart';
import '../locator.dart';

class MapProvider with ChangeNotifier {
  CRUDModel _crudeModel = locator<CRUDModel>();

  MapProvider() {
    _crudeModel.setpath('points');
  }
  var locData;

  getCurrentLocation() async {
    locData = await Location().getLocation();
    notifyListeners();
    print(locData.latitude);


  }
  Stream<QuerySnapshot> fetchAllMapAsStream() {
    return _crudeModel.streamAllDataCollection();
  }



}