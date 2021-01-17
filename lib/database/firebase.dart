import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSetup(String displayName, String age) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  users.add({'displayName': displayName, 'age': age, 'uid': uid});
  return;
}
