

import 'package:flutter/material.dart';
import 'package:notes_app/DeleteNotes.dart';
import 'package:notes_app/ShowPaage.dart';
import 'package:notes_app/addNotes.dart';
import 'package:notes_app/updateNotes.dart';


class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
       backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 140,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your',style: TextStyle(fontSize: 40,color: Colors.black),),
              Text('Notes App',style: TextStyle(fontSize: 40,color: Colors.black),)
            ],
          ),
          bottom: TabBar(
            labelColor: Colors.black,
            tabs: [
            Tab(child: Text("Add Notes"),),
            Tab(child: Text("Saved Notes"),),
             Tab(child: Text("Update Note"),),
             Tab(child: Text("Delete Notes"),)
          ]),
        ),
    
       body: TabBarView(children: [
        addNotesUi(),
        ShowPage(),
        UpdateNotes(),
        DeleteNotes(),
       ]),
      ),
    );
}
}


/// add note ui

class addNotesUi extends StatelessWidget {
  const addNotesUi({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
    children: [
    SizedBox(height: 170,),
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
         // color: Colors.blue[500],
          borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotes(),)),
              child: Container(
              height: 50,
              width: 50,
                decoration: BoxDecoration(
              color: Colors.blue[500],
              borderRadius: BorderRadius.circular(50),
              ),
                child: Icon(Icons.add,size: 32, color: Colors.white,)),),
                SizedBox(height: 5,),
                Text('Add Your Notes',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.black,),),
                SizedBox(height: 5,),
                Text('Tap on (+) for Add New Notes',style: TextStyle(fontSize: 17, color: Colors.black,),),
            ],
          ),
        ),
      ),

    ],
      );
  }
}