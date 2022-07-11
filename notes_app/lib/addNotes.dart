import 'package:flutter/material.dart';
import 'package:notes_app/DataBase_services.dart';
import 'package:notes_app/DeleteNotes.dart';
import 'package:notes_app/MainPage.dart';
import 'package:notes_app/ShowPaage.dart';
import 'package:progress_indicators/progress_indicators.dart';


class AddNotes extends StatefulWidget {

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final formkey = GlobalKey<FormState>();

  TextEditingController titleC = TextEditingController();

  TextEditingController detailC = TextEditingController();

  bool isadd = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 1,
        toolbarHeight: 140,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add',style: TextStyle(fontSize: 40,color: Colors.black),),
            Text('New Notes',style: TextStyle(fontSize: 40,color: Colors.black),)
          ],
        ),
        
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
             validator: (v) {
              if (v!.isEmpty) {
                return 'Title is Required';
              }
              return null;
            },
            controller: titleC,
            maxLength: 30,
            autocorrect: true,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.text_format_outlined),
              hintText: 'Enter Your Title',
              label: Text('Enter your Title'),
              border: OutlineInputBorder()
            ),
          ),
        ),
         Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
            validator: (v) {
              if (v!.isEmpty) {
                return 'Details is Required';
              }
              return null;
            },
            controller: detailC,
            maxLength: 1000,
            minLines: 1,
            maxLines: 10,
            autocorrect: true,
            decoration: InputDecoration(
              
              hintText: 'Enter Your Details',
              label: Text('Enter your Details'),
              border: OutlineInputBorder()
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(onPressed: (){
            if (formkey.currentState!.validate()) {
              
              setState(() {
                isadd=true;
              });
              DataBaseServices.addData(titleC.text, detailC.text).whenComplete((){
                setState(() {
                  isadd=false;
                  titleC.clear();
                  detailC.clear();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Notes add Successfully')));
                  Navigator.pop(context);
                });
              });

            }
          }, child: isadd==false? Text("Add Your Note", style: TextStyle(fontSize: 20),):CircularProgressIndicator(color: Colors.white,),
          style: ButtonStyle(minimumSize: MaterialStateProperty.all(Size(double.infinity, 50))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(onPressed: (){
            titleC.clear();
            detailC.clear();
          }, child: Text("Clear", style: TextStyle(fontSize: 20),),
          style: ButtonStyle(minimumSize: MaterialStateProperty.all(Size(double.infinity, 50))),
          ),
        ),
        SizedBox(height: 90,),
  IconButton(onPressed: ()async{
    if (titleC.text.isNotEmpty || detailC.text.isEmpty){
       return await mydialog1(context);
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
  }, icon: Icon(Icons.arrow_back_ios, color: Colors.blue[500],size: 30,))
      ],)),)
    );
  }
}


  Future mydialog1(BuildContext context,) {
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
                  Text('Do You want to Leave this page....?', style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                   ElevatedButton(
                      onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
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