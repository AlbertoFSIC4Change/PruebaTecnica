import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prueba_tecnica/cardlist.dart';
import 'package:prueba_tecnica/loginbutton.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica/resource.dart';
import 'database.dart';

class Home extends StatelessWidget {
  Home({super.key});


  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot?>.value(
      value: Database().queryData,
      initialData: null,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Home'),
            actions: [LoginButton()],
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: ListView(
              shrinkWrap: true,
              children: [
                Container(child: Text('Home')),
                CardList()],
          ),
          floatingActionButton: FloatingActionButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Resource(resourceId: "")),);},
            child: Icon(Icons.add),),
      ),
    );
  }
}
