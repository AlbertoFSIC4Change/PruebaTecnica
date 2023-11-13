import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica/app/models/resource.dart';
import 'package:prueba_tecnica/app/resource/resource_form.dart';
import 'package:prueba_tecnica/services/database.dart';


class ResourceEdit extends StatelessWidget {
  ResourceEdit({super.key, required this.resource});
  Resource resource;
  final formKey = GlobalKey<FormState>();

  void updateDatabase() {
    final form = formKey.currentState;
    if (form!.validate()) {
      try {
        form.save();
        Database().updateDatabaseEntry(resource);
      } catch (e) {
      }
    }
  }

  showAlertDialog(BuildContext context) async{

    Widget cancelButton = ElevatedButton(
      child: Text("Cancel"),
      onPressed:  () {Navigator.pop(context);},
    );
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        Database().deleteDatabaseEntry(resource!.id);
        Navigator.pop(context);
        Navigator.pop(context);
        },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Deleting Resource"),
      content: Text("Are you sure you want to delete?"),
      actions: [
        okButton,
        cancelButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(resource!.id),),
      body: ResourceForm(resource: resource),
      floatingActionButton: FloatingActionButton(onPressed: () async {await showAlertDialog(context);},
        child: Icon(Icons.remove),),
    );
  }
}