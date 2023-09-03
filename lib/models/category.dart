class Categoryy {
  final String id;
  final String name;
  final String arabicName;
  final String imageUrl;

  Categoryy({
    this.id = '',
    this.name = '',
    this.arabicName = '',
    this.imageUrl ='',
    
  });

  Categoryy.fromMap(Map snapshot, String id)
      : id = id,
        name = snapshot['name'] ?? '',
        arabicName = snapshot['arabicName'] ?? '',
        imageUrl = snapshot['imageUrl'];


  toJson() {
    return {
      "name": name,
      "arabicName": arabicName,
      "imageUrl": imageUrl,
    };
  }
}
