import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica/resource.dart';

class CardList extends StatefulWidget {
  const CardList({super.key});

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {


  @override
  Widget build(BuildContext context) {
    final cardList = Provider.of<QuerySnapshot>(context);

    List<Card> cardArray = [];
    for(var doc in cardList.docs){

      Card card = Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.album),
              title: Text('${doc.get('org')}'),
              subtitle: Text('${doc.get('type')}'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: Text('${doc.get('valid')}'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('EDIT'),
                  onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Resource(resourceId: doc.id)),);},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
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
