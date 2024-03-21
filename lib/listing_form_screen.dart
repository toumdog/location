import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ListingFormScreen extends StatefulWidget {
  const ListingFormScreen({super.key});

  @override
  _ListingFormScreenState createState() => _ListingFormScreenState();
}

class _ListingFormScreenState extends State<ListingFormScreen> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController dateNaissanceController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();
  final TextEditingController nbrPiecesController = TextEditingController();
  final TextEditingController etageController = TextEditingController();
  final TextEditingController nbrSalleDeBainController = TextEditingController();
  final TextEditingController nbrToilettesController = TextEditingController();
  bool balcon = false;
  bool parking = false;

  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        //print('Aucune image sélectionnée.');
      }
    });
  }

  @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    dateNaissanceController.dispose();
    adresseController.dispose();
    nbrPiecesController.dispose();
    etageController.dispose();
    nbrSalleDeBainController.dispose();
    nbrToilettesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajouter un bien à louer")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nomController,
              decoration: const InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: prenomController,
              decoration: const InputDecoration(labelText: 'Prénom(s)'),
            ),
            TextField(
              controller: dateNaissanceController,
              decoration: const InputDecoration(labelText: 'Date de naissance'),
            ),
            TextField(
              controller: adresseController,
              decoration: const InputDecoration(labelText: 'Adresse du bien'),
            ),
            TextField(
              controller: nbrPiecesController,
              decoration: const InputDecoration(labelText: 'Nombre de pièces'),
            ),
            TextField(
              controller: etageController,
              decoration: const InputDecoration(labelText: 'Étage'),
            ),
            TextField(
              controller: nbrSalleDeBainController,
              decoration: const InputDecoration(labelText: 'Nombre de salle de bains'),
            ),
            TextField(
              controller: nbrToilettesController,
              decoration: const InputDecoration(labelText: 'Nombre de toilettes'),
            ),
            SwitchListTile(
              title: const Text("Balcon"),
              value: balcon,
              onChanged: (bool value) {
                setState(() {
                  balcon = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text("Place de parking"),
              value: parking,
              onChanged: (bool value) {
                setState(() {
                  parking = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: getImage,
              child: const Text('Ajouter une photo'),
            ),
            if (_image != null) ...[
              Image.file(_image!, width: 100, height: 100),
              const SizedBox(height: 20),
            ],
            ElevatedButton(
              onPressed: () {
                // Logique pour soumettre le bien
              },
              child: const Text('Soumettre le bien'),
            ),
          ],
        ),
      ),
    );
  }
}
