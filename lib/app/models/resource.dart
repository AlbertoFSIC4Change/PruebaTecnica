
import 'package:cloud_firestore/cloud_firestore.dart';

class Resource{
  Resource({
    required this.id,
    required this.logo,
    required this.org,
    required this.photo,
    required this.place,
    required this.type,
    required this.valid
});

  String id;
  String logo;
  String org;
  String photo;
  String place;
  String type;
  String valid;

  factory Resource.fromMap(QueryDocumentSnapshot snapshot, String id){
    final String logo = snapshot.get('logo');
    final String org = snapshot.get('org');
    final String photo = snapshot.get('photo');
    final String type = snapshot.get('type');
    final String valid = snapshot.get('valid');
    final String place = snapshot.get('place');

    return Resource(
      id: id,
      logo: logo,
      org: org,
      photo: photo,
      place: place,
      type: type,
      valid: valid,
    );
  }

  static Resource newResource(){
    return Resource(
      id: "",
      logo: "",
      org: "",
      place: "",
      type: "",
      valid: "",
      photo: "");
  }
}