import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica/database.dart';

class Resource extends StatelessWidget {
  String resourceId;
  final formKey = GlobalKey<FormState>();
  Resource({super.key, required this.resourceId});

  var _org = "";
  var _place = "";
  var _valid = "";
  var _type = "";
  var _photo = "";
  var _logo = "";

  void updateDatabase() async{
    final form = formKey.currentState;
    if(form!.validate()){
      try{
        form.save();
        print('console: $resourceId');
        await Database().updateDatabaseEntry(resourceId, org: _org);
      } catch(e){

      }
    } else {
      print('console: Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(resourceId!),),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Organization'),
                initialValue: 'Organizacion',
                validator: (value) => value!.isEmpty ? 'Field cannot be Empty' : null,
                onSaved: (value) => _org = value!,
              ),
              ElevatedButton(onPressed: () async {updateDatabase(); Navigator.pop(context);},
                  child: Text('Update'))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {Database().deleteDatabaseEntry(resourceId); Navigator.pop(context);},
                                                child: Icon(Icons.remove),),
    );
  }
}
