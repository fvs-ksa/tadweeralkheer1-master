class Point {
  final String id;
  final String userId;
  final int quantity;
  final DateTime date;
  final String donationId;
  Point({this.id,this.userId,this.quantity,this.date,this.donationId});
  Point.fromMap(Map snapshot, String id)
      : id = id ?? '',
        userId = snapshot['userId'] ?? '',
        quantity = snapshot['quantity'] ?? 1,
        date = DateTime.parse(snapshot['date']) ?? DateTime.now(),donationId = snapshot["donationId"] ?? '';

  toJson() {
    return {
      "userId": userId,
      "quantity": quantity,
      "date": date.toString(),
      "donationId": donationId,
    };
  }

}
class Rating {
  final String id;
  final String userId;
  final double rate;
  final DateTime date;
  final String message;
  final String imageUrl;
  final String phoneNumber;
  final String name;
  final bool accepted;
  final String donationId;
  Rating({this.id,this.accepted,this.userId,this.rate,this.date,this.message,this.donationId,this.phoneNumber,this.name,this.imageUrl});
  Rating.fromMap(Map snapshot, String id)
      : id = id ?? '',
        userId = snapshot['userId'] ?? '',
        rate = snapshot['rate'] ?? 1,
  accepted=snapshot['accepted']??'',
        name=snapshot['name']??'',
        imageUrl=snapshot['imageUrl']??'https://upload.wikimedia.org/wikipedia/commons/e/e0/Userimage.png',
        phoneNumber=snapshot['phoneNumber']??'',
        date = DateTime.parse(snapshot['date']) ?? DateTime.now(),message = snapshot["message"] ?? '',donationId = snapshot["donationId"];

  toJson() {
    return {
      "userId": userId,
      "rate": rate,
      'name':name,
      'accepted':accepted,
      'imageUrl':imageUrl ??'https://upload.wikimedia.org/wikipedia/commons/e/e0/Userimage.png',
      'phoneNumber':phoneNumber,
      "date": date.toString(),
      "message": message,
      "donationId":donationId
    };
  }

}