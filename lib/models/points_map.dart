import 'package:location/location.dart';

class MapPoints {
  String id;
 // String location;
  String lat;
  String lng;
  String name;

  MapPoints({this.name='',
  //  this.location,
   this.lat='', this.lng='',
    this.id=''});

  MapPoints.fromJson(Map snapshot, String id)
      : id = id,
        name = snapshot['name'] ?? '',
 // location=snapshot['location'];
       lng = snapshot['lng'] ?? '',
       lat = snapshot['lat']??'';

  toJson() {
    return {
      "name": name,
      //"location":location,
     "lng": lng,
     "lat": lat,
    };
  }
}
