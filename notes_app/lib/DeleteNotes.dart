

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:notes_app/DataBase_services.dart';

class DeleteNotes extends StatelessWidget {
  const DeleteNotes({super.key});

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
                   child: Column(
                     children: [
                      
                       Card(
                        color: Colors.blue.shade100,
                         child: ExpansionTile(
                          trailing: GestureDetector(
                            onTap: (){
                              mydialog(context, res);
                            },
                            child: Icon(Icons.delete)),
                          title: Text("${res['title']}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                         children: [
                          
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${res['Details']}", style: TextStyle(fontSize: 15, ), textAlign: TextAlign.justify,),
                          ),
                         ],
                         ),
                       ),
                     ],
                   ),
                 );
               },);
               }
               else
               {
                return Center(child: CircularProgressIndicator());
               }
            })),
            
    );
  }

}

  Future<bool?> mydialog(BuildContext context, QueryDocumentSnapshot<Object?> res) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20.0)), //this right here
          child: Container(
            height: 130,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Do You want to Delete Your Notes....?', style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                   ElevatedButton(
                      onPressed: () {
                         Navigator.pop(context);
                         DataBaseServices.deleteNotes(res.id).whenComplete(() => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Notes Delete Successfully'))));
                      },
                      child: Text(
                        "Yes",
                        style: TextStyle(color: Colors.white),
                        
                      ),
                     // color: const Color(0xFF1BC0C5),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);

                      },
                      child: Text(
                        "No",
                        style: TextStyle(color: Colors.white),
                      ),
                     // color: const Color(0xFF1BC0C5),
                    ),
                 ],)
                ],
              ),
            ),
          ),
        );
      });
  }