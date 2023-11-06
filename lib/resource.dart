import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica/database.dart';

class Resource extends StatefulWidget {
  Resource({super.key, required String this.resourceId});
  String resourceId;
  final formKey = GlobalKey<FormState>();

  var _org = "";
  var _place = "";
  var _valid = "";
  var _type = "";
  var _photo = "";
  var _logo = "";

  @override
  State<Resource> createState() => _ResourceState();
}

class _ResourceState extends State<Resource> {

  void updateDatabase(context) async{
    final form = widget.formKey.currentState;
    if(form!.validate()){
      try{
        form.save();
        print('console: ${widget.resourceId}');
        await Database().updateDatabaseEntry(widget.resourceId, org: widget._org);
        Navigator.pop(context);
      } catch(e){

      }
    } else {
      print('console: Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildResourceForm(context);
  }

  Widget buildResourceForm(context){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.resourceId),),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Organization'),
                initialValue: widget._org,
                validator: (value) => value!.isEmpty ? 'Field cannot be Empty' : null,
                onSaved: (value) => widget._org = value!,
              ),
              ElevatedButton(onPressed: () async {updateDatabase(context);},
                  child: Text('Update'))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {Database().deleteDatabaseEntry(widget.resourceId); Navigator.pop(context);},
        child: Icon(Icons.remove),),
    );
  }
}
