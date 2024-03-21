import 'package:flutter/material.dart';
import 'login_screen.dart'; // Assurez-vous que le chemin est correct.
import 'properties_list.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Appartement',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Location Appartement'),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            Builder(
              builder: (BuildContext context) {
                return TextButton(
                  onPressed: () {
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: const Text(
                    'Se connecter',
                    style: TextStyle(
                      color: Colors.white, 
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: const Center(
          child: PropertiesList(),
        ),
      ),
    );
  }
}
