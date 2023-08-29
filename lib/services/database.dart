import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference usersCollection = FirebaseFirestore.instance.collection("users");

  Future updateUserData(String? email, String? name, String? avatar, String? lang, String? theme) async =>
      await usersCollection.doc(uid).set({
        'email': email,
        'name': name,
        'avatar': avatar,
        'lang': lang,
        'theme': theme,
      });
}
