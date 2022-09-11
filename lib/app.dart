import 'package:flutter/material.dart';
import '/screens/waste_list_screen.dart';



class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wasteagram',
      theme: ThemeData.dark(),
      home:  const WasteListScreen(),
    );
  }
}