// ignore_for_file: library_private_types_in_public_api, avoid_print, no_leading_underscores_for_local_identifiers
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../models/food_waste_post.dart';
import '../widgets/wasted_food_form.dart';




class NewWastePost extends StatefulWidget {
  const NewWastePost({Key? key}) : super(key: key);
  @override
  _NewWastePostState createState() => _NewWastePostState();
}

class _NewWastePostState extends State<NewWastePost> {

  File? image;
  String? fireURL;
  LocationData? locationData;

  var locationService = Location();
  var formKey = GlobalKey<FormState>();

  final picker = ImagePicker();
  final post = FoodWastePost();
  final format = DateFormat('EEEE, MMMM d, y');



  //
  //Referenced from class exploration camera_screen.dart
  //
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);

    setState(() {});

    var imageURL = '${DateTime.now()}.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(imageURL);
    UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;
    fireURL = await storageReference.getDownloadURL();
  }

  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }



  //
  //Referenced from class exploration share_location_screen.dart
  //
  void retrieveLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
    locationData = await locationService.getLocation();
    getImage();
    setState(() {});
  }




  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        appBar: AppBar(title: const Text('New Post')),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 300, width: 400,child: Image.file(image!)),
              Center(
                child: WasteForm(formKey: formKey, post: post, locationData: locationData, fireURL: fireURL),
              ),
            ],),
        ),
        bottomNavigationBar: uploadData(context),
      );
    }
  }


  //
  //Referenced from class exploration camera_screen.dart
  //
  Widget uploadData(BuildContext context) {
    return Semantics(
      onTapHint: 'Uploads new post',
      label:'Upload post to cloud',
      child: GestureDetector(
        child: Container(
            color: Colors.blue,
            height: 100,
            child: const Icon(Icons.cloud_upload_outlined, color: Colors.white, size: 50)),
        onTap: () async {
          post.date = format.format(DateTime.now());
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            FirebaseFirestore.instance.collection('posts').add({
              'date': post.date,
              'latitude': post.longitude,
              'longitude': post.latitude,
              'quantity': post.quantity,
              'imageURL': fireURL,
            });
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}