import 'package:brew_crew/models/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection("Brews");

  Future? updateUserData(String sugers, String name, int strength) async {
    return await brewCollection
        .doc(uid)
        .set({'sugers': sugers, 'name': name, 'strength': strength});
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((e) => Brew(
            name: e.get('name') ?? '',
            sugers: e.get('sugers') ?? '0',
            strength: e.get('strength')))
        .toList();
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }
}
