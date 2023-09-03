import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../models/place_location.dart';
import '../providers/map_provider.dart';

class MapScreenForDriver extends StatefulWidget {
  PlaceLocation initialLocation;

  MapScreenForDriver({Key key, this.initialLocation}) : super(key: key);

  @override
  State<MapScreenForDriver> createState() => _MapScreenForDriverState();
}

class _MapScreenForDriverState extends State<MapScreenForDriver> {
  GoogleMapController googleMapController;
  var location;
  List<Marker> myMarkers = [];

  // PolylinePoints polylinePoints = PolylinePoints();
  //Map<PolylineId, Polyline> polylines = {};
  @override
  void initState() {
    // getCurrentLocation();
    super.initState();
    // getDirections();

    myMarkers.add(
      Marker(
          markerId: MarkerId('0'),
          position: LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longitude),
          draggable: true,
          onDragEnd: (dragPosition) {
            print(dragPosition);
          }),
    );
    getDirections();
  }

  // var locData;
  // getCurrentLocation() async {
  //   setState(() async {
  //     locData = await Location().getLocation();
  //   });
  //   locData =  Location().getLocation();
  //
  //   print('${locData.latitude}////////////////////////////');
  //
  //
  // }
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};

  Future getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult polylineResult =
        await polylinePoints.getRouteBetweenCoordinates(
      // 'AIzaSyBS_WLni5YfR2VHwzTzf50iFsb4hmv9Vw8',
         // 'AIzaSyDgwuOAOGZqSqFoK-A_HEq-7a2Id3uldEM',
      'AIzaSyDsqz5UBGaB5_vuqkel95p4cppcinpWc2E',
      PointLatLng(
        // 21.5529449, 39.1843989
        Provider.of<MapProvider>(context).locData.latitude,
        Provider.of<MapProvider>(context).locData.longitude,
      ),
      // location.latitude,
      // location.longitude),
      PointLatLng(
          widget.initialLocation.latitude, widget.initialLocation.longitude),
      travelMode: TravelMode.walking,
    );

    if (polylineResult.points.isNotEmpty) {
      polylineResult.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(polylineResult.errorMessage);
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Theme.of(context).primaryColor,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
  }

  // getCurrentLocation()async{
  //   setState(() {
  //     location= Location().getLocation();
  //     print(location.latitude);
  //   });
  //
  // }

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('موقع العميل'),
      ),
      body: FutureBuilder(
        future: getDirections(),
        builder: (context, snapShot) {
          if (snapShot.hasError) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else {
            return GoogleMap(
              polylines: Set<Polyline>.of(polylines.values),
              markers: Set.from(myMarkers),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                setState(() {
                  googleMapController = controller;
                });
              },
              initialCameraPosition: CameraPosition(
                 zoom: 10,
                  target: LatLng(
                    // locData.latitude, locData.longitude,
                    mapProvider.locData.latitude,
                    mapProvider.locData.longitude,
                    // widget.initialLocation.latitude,
                    // widget.initialLocation.longitude,
                  )),
            );
          }
        },
      ),

      // locData == null
      //     ? Center(
      //         child: CircularProgressIndicator.adaptive(),
      //       )
      //     : GoogleMap(
      //         polylines: Set<Polyline>.of(polylines.values),
      //         markers: Set.from(myMarkers),
      //         myLocationButtonEnabled: true,
      //         myLocationEnabled: true,
      //         onMapCreated: (GoogleMapController controller) {
      //           setState(() {
      //             googleMapController = controller;
      //           });
      //         },
      //         initialCameraPosition: CameraPosition(
      //             zoom: 8,
      //             target: LatLng(
      //               21.5529449, 39.1843989,
      //               // mapProvider.locData.latitude,
      //               // mapProvider.locData.longitude,
      //               // widget.initialLocation.latitude,
      //               // widget.initialLocation.longitude,
      //             )),
      //       ),
    );
  }
}
