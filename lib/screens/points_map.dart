import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tadweer_alkheer/models/donation_point.dart';
import 'package:tadweer_alkheer/models/place_location.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadweer_alkheer/models/points_map.dart';

import 'package:tadweer_alkheer/providers/donation_points_provider.dart';
import 'package:tadweer_alkheer/providers/locale_provider.dart';
import 'package:tadweer_alkheer/providers/map_provider.dart';
import 'package:location/location.dart';

class PointsMapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;

  const PointsMapScreen({Key key,
    this.initialLocation =
    const PlaceLocation(latitude: 37.422, longitude: -122.084)})
      : super(key: key);

  @override
  _PointsMapScreen createState() => _PointsMapScreen();
}

class _PointsMapScreen extends State<PointsMapScreen> {
  // var myMarkers = HashSet<Marker>();
  List<dynamic> markerss = [];
  List<Marker> loc = [];

  // Map<MarkerId,Marker>markers=<MarkerId,Marker>{};
  GoogleMapController googleMapController;
  double latitude;
  double longitude;
  var locData;
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
  //   // Marker f1 = Marker(
  //   //     markerId: MarkerId('25'),
  //   //     position: LatLng(markerss[0].lat, markerss[0].lng),
  //   //     infoWindow: InfoWindow(title: markerss[0].name),
  //   //     onTap: () {
  //   //       _selectLocation(markerss[0].lat, markerss[0].lng);
  //   //     },
  //       //icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
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
  //     markerss.add(f4);
  //    // markerss.add(f1);
  //     markerss.add(f2);
  //     markerss.add(f3);
  //   });
  // }

  _selectLocation(double lat, double long) {
    setState(() {
      latitude = lat;
      longitude = long;
      //_pickedLocation = position;
    });
  }

  // var locData;
  //
  // getCurrentLocation() async {
  //   locData = await Location().getLocation();
  //   print(locData.latitude);
  //
  //
  // }

  // void initState() {
  //   super.initState();
  //   intilize();
  //   // WidgetsBinding.instance.addPostFrameCallback(
  //   //   (_) => _scaffoldKey.currentState.showSnackBar(
  //   //     SnackBar(
  //   //       duration: const Duration(seconds: 4),
  //   //       content: RichText(
  //   //         text: TextSpan(
  //   //           style: TextStyle(
  //   //             color: Colors.white,
  //   //           ),
  //   //           children: [
  //   //             TextSpan(text: AppLocalizations.of(context).clickon),
  //   //             WidgetSpan(
  //   //               child: Padding(
  //   //                 padding: const EdgeInsets.symmetric(horizontal: 2.0),
  //   //                 child: Icon(
  //   //                   Icons.place,
  //   //                   color: Colors.red,
  //   //                 ),
  //   //               ),
  //   //             ),
  //   //             TextSpan(text: AppLocalizations.of(context).tonavigate),
  //   //           ],
  //   //         ),
  //   //       ),
  //   //       backgroundColor: Colors.grey,
  //   //     ),
  //   //   ),
  //   // );
  // }

  // Riyadh 24.682110000000023  46.68722000000008
  // madeina
  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final currentLocale = localeProvider.locale;
   return  Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
// automaticallyImplyLeading: false,
          title: Text(AppLocalizations
              .of(context)
              .mapLocation),
        ),
        body:mapProvider.locData==null?Center(child: CircularProgressIndicator.adaptive(),): StreamBuilder(
            stream: mapProvider.fetchAllMapAsStream(),
            builder: (ctx, mapPointsSnapShot) {
              if (mapPointsSnapShot.hasData) {
                print('markers');
                markerss = mapPointsSnapShot.data.docs
                    .map((doc) => MapPoints.fromJson(doc.data(), doc.id))
                    .toList();
                for (int i = 0; i < markerss.length; i++) {
                  LatLng latlng = new LatLng(double.parse(markerss[i].lat),
                      double.parse(markerss[i].lng));
                  var ri=latlng.latitude * 10;
                  // LatLng latlng = new LatLng(markerss[i].lat,
                  //     markerss[i].lng);
                  this.loc.add(Marker(
                    markerId: MarkerId(markerss[i].id.toString()),
                    position: latlng,
                    onTap: () {
                      _selectLocation(double.parse(markerss[i].lat),
                          double.parse(markerss[i].lng));
                    },
                    infoWindow: InfoWindow(title: markerss[i].name),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed),
                  ));
                }
              } else {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(mapProvider.locData.latitude,
                      mapProvider.locData.longitude),
                  zoom: 6,
                ),
                onMapCreated: (GoogleMapController controller) {
                  setState(() {
                    googleMapController = controller;
                  });
                },
                markers: Set<Marker>.of(loc),
              );
            }));
  }
}
