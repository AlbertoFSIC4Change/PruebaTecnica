import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica/app/resource/resource_edit.dart';
import 'package:prueba_tecnica/services/database.dart';

import '../models/resource.dart';

class CardList extends StatefulWidget {
  const CardList({super.key});

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {

  Future<String> getCardImage(String url) async{
    return await Database().getImageUrl(url);
  }

  void displayCardDialog(Resource resource) {

    Widget editButton = ElevatedButton(
      child: Text("Edit Resource"),
      onPressed: () {
        debugPrint('Edit pressed');
      },
    );

    Dialog cardDialog = Dialog(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: FutureBuilder<String>(
                  future: getCardImage('logos/${resource.logo}'),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if(snapshot.hasData){
                      return Image(
                          image: NetworkImage(snapshot.data!),
                          width: 35,
                          height: 35,
                          fit: BoxFit.cover,
                          color: null
                      );
                    }else{
                      return const Icon(Icons.front_loader, size: 35);
                    }
                  }),
              title: Text(resource.org),
              subtitle: Text(resource.place),
            ),
            SizedBox( height: 15.0 ),
            Container(
              height: 200.0,
              child: FutureBuilder<String>(
                  future: getCardImage('photos/${resource.photo}'),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if(snapshot.hasData){
                      return Ink.image(
                          image: NetworkImage(snapshot.data!),
                          fit: BoxFit.fill,
                      );
                    }else{
                      return const Icon(Icons.front_loader, size: 35);
                    }
                  }),
            ),
            SizedBox( height: 15.0, ),
            Container(
              padding: const EdgeInsets.all(15.0),
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(resource.type, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  SizedBox( height: 5.0, ),
                  Text(resource.valid, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  SizedBox( height: 5.0, ),
                  Text('[DESCRIPCION]', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('Edit Resource'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ResourceEdit(resource: resource)),);
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return cardDialog;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final cardList = Provider.of<QuerySnapshot>(context);

    List<Card> cardArray = [];
    for(var doc in cardList.docs){
      Resource resource = Resource.fromMap(doc, doc.id);

      Card card = Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {displayCardDialog(resource);} ,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.album),
                title: Text(resource.org),
                subtitle: Text(resource.type),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: Text(resource.valid),
                    onPressed: null,
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      );

      cardArray.add(card);
    }

    return Center(
      child: Column(
        children: cardArray,
      ),
    );
  }
}