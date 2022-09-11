// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasteagram/screens/new_waste_post.dart';
import 'waste_detail_screen.dart';
import '../models/food_waste_post.dart';


//
//Referenced from class exploration entry_list.dart
//
class WasteListScreen extends StatefulWidget {
    const WasteListScreen({super.key});

  @override
  _WasteListScreen createState() => _WasteListScreen();
}

final format = DateFormat('EEEE, MMMM d');

class _WasteListScreen extends State<WasteListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: const Center(child: Text('Wasteagram'))),
        floatingActionButton: cameraFab(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //STREAMBUILDER  
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').orderBy('date', descending: false).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData &&
                snapshot.data!.docs != null &&
                snapshot.data!.docs.isNotEmpty) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var post = snapshot.data!.docs[index];
                       
                        var postDetails = FoodWastePost(   
                          date: post['date'],
                          imageURL: post['imageURL'],
                          quantity: post['quantity'],
                          latitude: post['latitude'],
                          longitude: post['longitude'],);   
                      
                        return Semantics(
                          onTapHint: 'View details on Waste Post',
                          label: 'Waste Post Details',
                          enabled: true,
                          child: ListTile(  
                            title: Text(post['date'].toString(), style: Theme.of(context).textTheme.headline6,),
                            trailing: Text(post['quantity'].toString(), style: Theme.of(context).textTheme.headline5,),
                            onTap: () { Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => WasteDetailScreen(
                                post: postDetails
                            )
                            )
                              );
                              },       
                            ),
                        );},
                    ),
                  ),
                ],);
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(child: CircularProgressIndicator()),
                ],
              );
            }
          }),
    );
  }


    Widget cameraFab(BuildContext context) {
    return Semantics(
      onTapHint: 'Select an image',
      label: 'Camera button',
      enabled: true,
      button: true,
      child: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
          context, MaterialPageRoute(builder: (context) => const NewWastePost()));
        },
        child: const Icon(Icons.camera_alt_outlined),
      )
    );
  }



}