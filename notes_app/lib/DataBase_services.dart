import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
class DataBaseServices{
  static Future<void> addData(String title, String details)async{

  await firebaseFirestore.collection('Notes').add({
      "title":title,
      "Details": details,
    }).whenComplete(() => print("Notes SuccessFull Add")).catchError((e){
      print(e.toString());
    });
  }

  static Future<void> deleteNotes(String id)async{
  await firebaseFirestore.collection('Notes').doc(id).delete();
  }
  static Future<void> updateNotes(String id, String title, String detail)async{
await firebaseFirestore.collection('Notes').doc(id).update({
'title': title,
'Details': detail
});
  }
}