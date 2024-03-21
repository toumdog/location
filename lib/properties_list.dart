import 'package:flutter/material.dart';
import 'database_helper.dart';


class PropertiesList extends StatefulWidget {
  const PropertiesList({Key? key}) : super(key: key);
  @override
  _PropertiesListState createState() => _PropertiesListState();
}

class _PropertiesListState extends State<PropertiesList> {
  late Future<List<Map<String, dynamic>>> _propertiesList;

  @override
  void initState() {
    super.initState();
    _propertiesList = DatabaseHelper.instance.getProperties();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _propertiesList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var property = snapshot.data![index];
              return ListTile(
                title: Text(property['adresse']),
                subtitle: Text('Pièces: ${property['nbrPieces']}'),
                // Affichez d'autres informations sur le bien ici
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Erreur: ${snapshot.error}');
        }
        return CircularProgressIndicator();
      },
    );
  }
}
