import 'package:flutter/material.dart';
import '/models/food_waste_post.dart';


class WasteDetailScreen extends StatelessWidget {

  final FoodWastePost post;
  const WasteDetailScreen({ Key? key, required this.post }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wasteagram'),
          leading: Semantics
          (onTapHint: 'Go Back',
            child: const BackButton()),),
      body: layout(context),

    );
  }



  Widget layout(context){
    return Semantics(
      label: 'Date, image, quantity, and location of waste post',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:40.0, bottom: 40.0),
            child: Text(post.date.toString(), style: Theme.of(context).textTheme.headline5,),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Center(child: SizedBox(height: 20,)),
            ]),

          //image goes in this SizedBox  
          SizedBox(height:300, width: 400, child: Image.network(post.imageURL.toString())),

          //Item quantity
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Text('${post.quantity.toString()} items',style: Theme.of(context).textTheme.headline4),
          ),

          //location
          Padding(
            padding: const EdgeInsets.only(top:20.0),
            child: Text(
              'Location: ${post.longitude.toString()}, ${post.latitude.toString()}', 
              style: Theme.of(context).textTheme.subtitle1
              ),
          )
        ]),
    );
  }


}