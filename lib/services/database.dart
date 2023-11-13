
import 'package:cloud_firestore/cloud_firestore.dart';
import '../app/models/resource.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Database {
  final firebaseStorage = FirebaseStorage.instance;
  final CollectionReference collectionData = FirebaseFirestore.instance.collection('data');

  Stream<QuerySnapshot> get queryData {
    return collectionData.snapshots();
  }

  Future<void> updateDatabaseEntry(Resource resource) async {
    if (resource.id.isEmpty) {
      await collectionData.add({
        "org": resource.org,
        "place": resource.place,
        "valid": resource.valid,
        "type": resource.type,
        "photo": resource.photo,
        "logo": resource.logo
      });
    } else {
      final Map<String, String> docMap = {};
      docMap['org'] = resource.org;
      docMap['type'] = resource.type;
      docMap['valid'] = resource.valid;
      docMap['place'] = resource.place;
      docMap['photo'] = resource.photo;
      docMap['logo'] = resource.logo;

      await collectionData.doc(resource.id).update(docMap);
    }
  }

  Future<void> deleteDatabaseEntry(String resourceId) async {
    await collectionData.doc(resourceId).delete();
  }

  Future<String> getImageUrl(String url) async{
    String imageUrl = await firebaseStorage.ref().child(url).getDownloadURL();
    return imageUrl;
  }

}
