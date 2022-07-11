import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:notes_app/DataBase_services.dart';

class ShowPage extends StatelessWidget {
  const ShowPage({super.key});
static BuildContext? showContext;

  @override
  Widget build(BuildContext Context) {
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
                  final a = snapshot.data!.docs.length;
                  if (a<0) {
                    return Text('No Notes add');
                  }
                 else{
                  return  Padding(
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
                     ),
                   ),
                 );
                 }
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