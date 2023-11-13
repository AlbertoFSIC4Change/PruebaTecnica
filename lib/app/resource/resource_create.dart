
import 'package:flutter/material.dart';
import 'package:prueba_tecnica/app/models/resource.dart';
import 'package:prueba_tecnica/app/resource/resource_form.dart';
import '../../services/database.dart';

class ResourceCreate extends StatelessWidget {
  ResourceCreate({super.key});
  Resource resource = Resource.newResource();
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Creating new Resource'),),
      body: ResourceForm(resource: resource,)
    );
  }
}