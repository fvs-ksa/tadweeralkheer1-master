// map page + i have a thing to add here which is #111.
import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/place_location.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/location_input.dart';
import 'add_donation_screen.dart';

class MapScreen extends StatefulWidget {
 PlaceLocation initialLocation;
  bool isSelecting;

  MapScreen({this.initialLocation =
  const PlaceLocation(latitude: 37.422, longitude: -122.084),
    this.isSelecting = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng latLn;
  // PlaceLocation initialLocation;
  // bool isSelecting;

  // var myMarkers = HashSet<Marker>();
  List<Marker> myMarker = [];
  bool select = false;

  // Map<MarkerId,Marker>markers=<MarkerId,Marker>{};
  GoogleMapController googleMapController;
  double latitude;
  double longitude;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // void gatMarkers(double lat,double long){
  //  MarkerId markerId=MarkerId(lat.toString()+long.toString());
  //  Marker _marker=Marker(
  //    markerId: markerId,
  //   position: LatLng(lat, long),
  //   infoWindow: InfoWindow(title: 'مؤسسه تدوير الخير فرع سكاكا'),

  //       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
  //  );
  //  setState(() {
  //    markers[markerId]=_marker;
  //   });
  // }

  // intilize() {
  //   Marker f1 = Marker(
  //       markerId: MarkerId('25'),
  //       position: LatLng(29.953894, 40.197044),
  //       infoWindow: InfoWindow(title: 'مؤسسه تدوير الخير فرع سكاكا'),
  //       onTap: () {
  //         _selectLocation(29.953894, 40.197044);
  //       },
  //       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
  //   Marker f2 = Marker(
  //       markerId: MarkerId('26'),
  //       position: LatLng(21.543333, 39.172779),
  //       infoWindow: InfoWindow(title: 'مؤسسه تدوير الخير فرع جده '),
  //       onTap: () {
  //         _selectLocation(21.543333, 39.172779);
  //       },
  //       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
  //   Marker f3 = Marker(
  //       markerId: MarkerId('27'),
  //       position: LatLng(18.329384, 42.759365),
  //       infoWindow: InfoWindow(title: 'مؤسسه تدوير الخير فرع خميس مشيط'),
  //       onTap: () {
  //         _selectLocation(18.329384, 42.759365);
  //       },
  //       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
  //   Marker f4 = Marker(
  //     markerId: MarkerId('28'),
  //     position: LatLng(25.994478, 45.318161),
  //     onTap: () {
  //       _selectLocation(25.994478, 45.318161);
  //     },
  //     infoWindow: InfoWindow(title: 'مؤسسه تدوير الخير فرع الرياض'),
  //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
  //   );
  //   setState(() {
  //     myMarker.add(f4);
  //     myMarker.add(f1);
  //     myMarker.add(f2);
  //     myMarker.add(f3);
  //   });
  // }

  // _selectLocation(double lat, double long) {
  //   setState(() {
  //     latitude = lat;
  //     longitude = long;
  //     //_pickedLocation = position;
  //   });
  // }

  void initState() {
    super.initState();
    //intilize();
    WidgetsBinding.instance.addPostFrameCallback(
          (_) =>
        //  _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 4),
              content: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(text: AppLocalizations
                        .of(context)
                        .clickon),
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Icon(
                          Icons.place,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    TextSpan(text: AppLocalizations
                        .of(context)
                        .tonavigate),
                  ],
                ),
              ),
              backgroundColor: Colors.grey,
            ),
          );
  //  );
  }

  // Riyadh 24.682110000000023  46.68722000000008
  // madeina
  @override
  Widget build(BuildContext context) {
    // var myMarkers = HashSet<Marker>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
       // automaticallyImplyLeading: true,
        title: Text(AppLocalizations
            .of(context)
            .mapLocation),
        actions: [
          if (widget.isSelecting)
            IconButton(
                icon: (Icon(Icons.check)),
                // onPressed: _pickedLocation == null
                //     ? null
                //     : () {
                //         Navigator.of(context).pop(_pickedLocation);
                //       },
                onPressed: latLn == null
                    ? null
                    : () async {
                  print('kk');
                  //print(PlaceLocation().latitude.toString());
                  LocationInput(_selectPlace);
                  print(widget.initialLocation.longitude);
                  Navigator.of(context).pop(
                    latLn

                  );
                })
        ],
      ),
      body: GoogleMap(

        myLocationEnabled: true,
        myLocationButtonEnabled: true,
       // mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 14,
        ),
        // onTap: widget.isSelecting ? _selectLocation : null,
        //  onTap: (tapped){
        //    _selectLocation(tapped.latitude, tapped.longitude);
        //    print(tapped.latitude.toString());
        //    print(tapped.longitude.toString());
        //   // gatMarkers(tapped.latitude,tapped.longitude);
        //  },
        // (_pickedLocation == null && widget.isSelecting == true)
        //     ? Set<Marker>()
        //     : Set<Marker>().add(Marker(
        //   markerId: MarkerId('m1'),
        //   position: _pickedLocation ??
        //       LatLng(
        //         widget.initialLocation.latitude,
        //         widget.initialLocation.longitude,
        //       ),
        // )),
        onMapCreated: (GoogleMapController controller) {
          setState(() {
            googleMapController = controller;
          });
        },
        markers: Set.from(myMarker),
        // markers:myMarkers.map((e) => e).toSet(),
        //Set<Marker>.of(markers.values),
        onTap: _handleTap,
      ),
    );
  }

  void _selectPlace(double lat, double lng) {
    setState(() {
      // widget.initialLocation = PlaceLocation(
      //   latitude: lat,
      //   longitude: lng,
      // );
      latLn=LatLng(lat, lng);
    });
  }

  _handleTap(LatLng tappedPoint) {
    print(tappedPoint.toString());
    setState(() {
      //this is to add one marker one mark if i want more than one marker : delete myMarker[];
      myMarker = [];
      myMarker.add(
        Marker(
            markerId: MarkerId(tappedPoint.toString()),
            position: tappedPoint,
            draggable: true,

            onDragEnd: (dragPosition) {
              print(dragPosition);
            }
        ),
      );
      // longitude=tappedPoint.longitude;
      // latitude=tappedPoint.latitude;
      // widget.initialLocation = PlaceLocation(
      //   latitude: tappedPoint.latitude,
      //   longitude: tappedPoint.longitude,
      // );
      latLn=LatLng(tappedPoint.latitude,tappedPoint.longitude);
      print(latLn.latitude);
      print('object');

    });
  }
}
