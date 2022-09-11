import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import '../models/food_waste_post.dart';



class WasteForm extends StatelessWidget {
  const WasteForm({Key? key,
    required this.formKey,
    required this.post,
    required this.locationData,
    required this.fireURL,
  }) : super(key: key);


  final GlobalKey<FormState> formKey;
  final String? fireURL;
  final LocationData? locationData;
  final FoodWastePost post;


  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 14.0, right: 14.0),
        child: Semantics(
          onTapHint: 'Enter the waste quantity',
          label: 'Form field for quantity',
          child: TextFormField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            style: Theme.of(context).textTheme.headline5,
            decoration: const InputDecoration(
            hintText: 'Number of Wasted Items',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Number of Wasted Items";
              } else {
                return null;
              }
            },
            onSaved: (value) {
              post.quantity = int.parse(value!);
              post.imageURL = fireURL;
              post.longitude = locationData!.longitude as double;
              post.latitude = locationData!.latitude as double;

            },
          ),
        ),
      ),
    );
  }



}