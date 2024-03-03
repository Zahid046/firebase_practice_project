import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference brewsCollection = FirebaseFirestore.instance.collection('brews');

  Future<dynamic> updateUserData(String sugars, String name, int strength) async {
    return await brewsCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // get brews stream
  Stream<QuerySnapshot?> get brews {
    return brewsCollection.snapshots();
  }
}
