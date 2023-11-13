import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prueba_tecnica/app/home/cardlist.dart';
import 'package:prueba_tecnica/common_widgets/loginbutton.dart';
import 'package:provider/provider.dart';
import '../../services/database.dart';
import '../resource/resource_create.dart';

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
                CardList()],
          ),
          floatingActionButton: FloatingActionButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ResourceCreate()),);},
            child: Icon(Icons.add),),
      ),
    );
  }
}
