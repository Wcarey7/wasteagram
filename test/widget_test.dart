import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/models/food_waste_post.dart';


//
//Referenced from class exploration video: Testing and Debugging
//
void main() {

   final format = DateFormat('EEEE, MMMM d, y');

  //TEST 1
  test('Post created from map should have appropriate property values', (){
    final date = format.format(DateTime.now());
    const url = 'test';
    const quantity = 3;
    const latitude = 32.6456;
    const longitude = -103.7921568;

 
 final foodPost = FoodWastePost.fromMap({
    'date': date,
    'imageURL': url,
    'quantity': quantity,
    'latitude': latitude,
    'longitude': longitude  
 });

    expect(foodPost.date, date);
    expect(foodPost.imageURL, url);
    expect(foodPost.quantity, quantity);
    expect(foodPost.latitude, latitude);
    expect(foodPost.longitude, longitude);

  });


  //TEST 2
  test('Quantity in post created from map should equal 3',(){
    final date = format.format(DateTime.now());
    const url = 'test';
    const quantity = 3;
    const latitude = 32.6456;
    const longitude = -103.7921568;


     final foodPost = FoodWastePost.fromMap({
    'date': date,
    'imageURL': url,
    'quantity': quantity,
    'latitude': latitude,
    'longitude': longitude  
 });

      expect(foodPost.quantity, 3);

  });


  //TEST 3
  test('url in post created from map should equal test.jpg',(){
    final date = format.format(DateTime.now());
    const url = 'test.jpg';
    const quantity = 3;
    const latitude = 32.6456;
    const longitude = -103.7921568;


     final foodPost = FoodWastePost.fromMap({
    'date': date,
    'imageURL': url,
    'quantity': quantity,
    'latitude': latitude,
    'longitude': longitude  
 });

      expect(foodPost.imageURL, 'test.jpg');

  });
}