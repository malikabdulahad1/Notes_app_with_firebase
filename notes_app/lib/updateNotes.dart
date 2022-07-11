import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:notes_app/DataBase_services.dart';
import 'package:notes_app/updatePage.dart';

class UpdateNotes extends StatelessWidget {
  
bool? isupdate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      // appBar: AppBar(
      //   toolbarHeight: 140,
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   title: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text('Your',style: TextStyle(fontSize: 40,color: Colors.black),),
      //       Text('Notes App',style: TextStyle(fontSize: 40,color: Colors.black),)
      //     ],
      //   ),
        
      // ),
      body: StreamBuilder(
            stream: firebaseFirestore.collection('Notes').snapshots(),
            builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
               if (snapshot.hasData) {
                 return ListView.builder(
                
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final res = snapshot.data!.docs[index];
                 return Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Card(
                                        color: Colors.blue.shade100,

                     child: ExpansionTile(title: Container(
                      child: Text("${res['title']}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                     children: [
                      
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${res['Details']}", style: TextStyle(fontSize: 15, ), textAlign: TextAlign.justify,),
                      ),
                      
                     ],
                     trailing: IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePage(
                        id: res.id,
                        title: res['title'],
                        detail: res['Details'],
                        
                      ),
                      
                      ));
                     }, icon: Icon(Icons.edit)),
                     ),
                   ),
                 );
               },);
               }
               else
               {
                return Center(child: CircularProgressIndicator());
               }
            }))
    );
  }
}