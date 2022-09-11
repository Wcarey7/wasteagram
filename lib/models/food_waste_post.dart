//model class
class FoodWastePost {
  
  String? date;
  String? imageURL;
  int? quantity;
  double? latitude;
  double? longitude;


  //
  //Referenced from class exploration character.dart
  //
  FoodWastePost({ this.date,  this.imageURL,  this.quantity,  this.latitude,  this.longitude});

  factory FoodWastePost.fromMap(Map<String, dynamic>map ) {   
    return FoodWastePost(

        date: map['date'],
        imageURL: map['imageURL'],
        quantity: map['quantity'],
        latitude: map['latitude'],
        longitude: map['longitude']);
  }
  
}