import 'package:tadweer_alkheer/models/place_location.dart';

class Issue {
  final String id;
  final bool isIssued;
  final String phoneNumberDetails;
  final String userId;
  final String donationId;
  final String content;
  final String status;
  final PlaceLocation location;
  final String category;
  final DateTime donationDate;
  final DateTime date;

  Issue(
      {this.donationDate,
      this.date,
      this.status,
      this.isIssued,
      this.phoneNumberDetails,
      this.category,
      this.id,
      this.location,
      this.content,
      this.userId,
      this.donationId});

  Issue.fromMap(
    Map snapShot,
    String id,
  )   : id = id ?? '',
        phoneNumberDetails = snapShot['phoneNumberDetails'] ?? '',
        userId = snapShot['userId'] ?? '',
        isIssued=snapShot['isIssued']??true,
        donationId = snapShot['donationId'] ?? '',
        content = snapShot['content'] ?? 'لم يتم التواصل معي حتى الان',
        status = snapShot['status'] ?? '',
        location = PlaceLocation(
              latitude: snapShot['latitude'],
              longitude: snapShot['longitude'],
              address: snapShot['pickupAddress'],
            ) ??
            '',
        category = snapShot['category'] ?? '',
        donationDate = snapShot['donationDate'] ?? '',
        date = DateTime.now();
  toJson(){
    return {
    'phoneNumberDetails':phoneNumberDetails,
      'userId':userId,
      'donationId':donationId,
      'content':content,
      'status':status,
      'isIssued':isIssued,
      'category':category,
      'donationDate':donationDate.toString(),
      'date':date.toString(),
      'latitude':location.latitude,
      'longitude':location.longitude,
      'pickupAddress':location.address,
    };

}}
