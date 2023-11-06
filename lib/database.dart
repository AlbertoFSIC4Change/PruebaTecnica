import 'package:cloud_firestore/cloud_firestore.dart';

class Database{
  final CollectionReference collectionData = FirebaseFirestore.instance.collection('data');

  Stream<QuerySnapshot> get queryData{
    return collectionData.snapshots();
  }

  Future<void> addDatabaseEntry() async{
    await collectionData.add({
      "org" : "ULPGC",
      "place" : "Canarias",
      "valid" : "",
      "type" : "",
      "photo" : "",
      "logo" : ""
    });
  }

  Future<void> updateDatabaseEntry(String resourceId, {String org="", String place="", String valid="", String type="Test", String photo="", String logo=""}) async{
    if(resourceId.isEmpty){
      await collectionData.add({
        "org" : org,
        "place" : place,
        "valid" : valid,
        "type" : type,
        "photo" : photo,
        "logo" : logo,
      });
    } else {
      final Map<String, String> docMap = {};
      if(org.isNotEmpty) docMap['org'] = org;
      if(place.isNotEmpty) docMap['type'] = place;
      if(valid.isNotEmpty) docMap['valid'] = valid;

      await collectionData.doc(resourceId).update(docMap);
    }
  }

  Future<void> deleteDatabaseEntry(String resourceId) async{
    await collectionData.doc(resourceId).delete();
  }

  Future<DocumentSnapshot?> getResource(String resourceId) async{
    return await collectionData.doc(resourceId).get();
  }

}