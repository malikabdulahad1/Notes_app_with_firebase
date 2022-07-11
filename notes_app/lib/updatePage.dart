import 'package:flutter/material.dart';
import 'package:notes_app/DataBase_services.dart';


class UpdatePage extends StatefulWidget {
String? title;
String? detail;
String? id;

UpdatePage({this.title, this.detail, this.id});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
bool? isupdate=false;

  final formkey = GlobalKey<FormState>();

  TextEditingController titleC = TextEditingController();

  TextEditingController detailC = TextEditingController();

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
            Text('Update',style: TextStyle(fontSize: 40,color: Colors.black),),
            Text('your Notes',style: TextStyle(fontSize: 40,color: Colors.black),)
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
              label: Text('${widget.title}'),
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
              label: Text("${widget.detail}"),
              border: OutlineInputBorder()
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(onPressed: (){
            if (formkey.currentState!.validate()) {
              setState(() {
                 isupdate=true;
              });
             
              DataBaseServices.updateNotes(widget.id!, titleC.text, detailC.text).whenComplete((){
                setState(() {
                  isupdate=false;
                  titleC.clear();
                  detailC.clear();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Notes Update Successfully')));
                  Navigator.pop(context);
                });
              });
              
            }

          }, 
          child: isupdate==false?Text("Update Your Note", style: TextStyle(fontSize: 20),):CircularProgressIndicator(color: Colors.white,),
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

      ],)),)
    );
  }
}