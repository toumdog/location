import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'database_helper.dart'; // Assurez-vous que ce chemin correspond à l'emplacement de votre DatabaseHelper
import 'package:logger/logger.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
  bool isLender = false;

  File? _image;
  final picker = ImagePicker();
  final logger = Logger();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        logger.d('Aucune image sélectionnée.');
      }
    });
  }

  void _submitForm() async {
    Map<String, dynamic> userData = {
      'email': emailController.text,
      'password': passwordController.text, 
      'nom': nomController.text,
      'prenom': prenomController.text,
      'dateNaissance': dateNaissanceController.text,
      'adresse': isLender ? adresseController.text : '',
      'nbrPieces': isLender ? nbrPiecesController.text : '0',
      'etage': isLender ? etageController.text : '0',
      'nbrSalleDeBain': isLender ? nbrSalleDeBainController.text : '0',
      'nbrToilettes': isLender ? nbrToilettesController.text : '0',
      'balcon': balcon ? 1 : 0,
      'parking': parking ? 1 : 0,
      'photoPath': _image?.path ?? '',
    };

    final id = await DatabaseHelper.instance.insertUser(userData);
    print('Utilisateur inséré id : $id');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inscription")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, decoration: const InputDecoration(labelText: 'Mot de passe'), obscureText: true),
            TextField(controller: nomController, decoration: const InputDecoration(labelText: 'Nom')),
            TextField(controller: prenomController, decoration: const InputDecoration(labelText: 'Prénom(s)')),
            TextField(controller: dateNaissanceController, decoration: const InputDecoration(labelText: 'Date de naissance')),
            SwitchListTile(title: const Text("Mettre en location ?"), value: isLender, onChanged: (bool value) { setState(() { isLender = value; }); }),
            if (isLender) ...[
              TextField(controller: adresseController, decoration: const InputDecoration(labelText: 'Adresse')),
              TextField(controller: nbrPiecesController, decoration: const InputDecoration(labelText: 'Nombre de pièces')),
              TextField(controller: etageController, decoration: const InputDecoration(labelText: 'Étage')),
              TextField(controller: nbrSalleDeBainController, decoration: const InputDecoration(labelText: 'Nombre de salle de bains')),
              TextField(controller: nbrToilettesController, decoration: const InputDecoration(labelText: 'Nombre de toilettes')),
              SwitchListTile(title: const Text("Balcon"), value: balcon, onChanged: (bool value) { setState(() { balcon = value; }); }),
              SwitchListTile(title: const Text("Place de parking"), value: parking, onChanged: (bool value) { setState(() { parking = value; }); }),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: getImage, child: const Text('Ajouter une photo')),
                            if (_image != null) ...[
                Image.file(_image!, width: 100, height: 100),
                const SizedBox(height: 20),
              ],
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('S\'inscrire'),
            ),
          ],
        ),
      ),
    );
  }
}
