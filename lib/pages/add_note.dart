import 'package:flutter/material.dart';
import 'package:note_pad/database/databaseHelper.dart';
import 'package:note_pad/models/note.dart';
import 'package:provider/provider.dart';

import 'home.dart';
class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String title = '' ;
  String  content = '';
  bool titleTapped = false ;
  bool contentTapped = false ;
 // DbHelper helper ;

  @override
  void initState() {
    super.initState();
   // helper = DbHelper();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.grey[100],
      appBar: AppBar(
        actions: [
          Container(
            margin: EdgeInsets.only( right: 20 ,),
            child: titleTapped ? title.isNotEmpty ?  
            Consumer<DbHelper>(
              builder: (BuildContext context , DbHelper dbHelper  , child){
                return IconButton(icon: Icon( Icons.done ,size: 25,), onPressed: () async{
                Note note = Note({'title':title , 'content' : content });
                 await dbHelper.insertNote(note);
                 Navigator.of(context).pop();
               // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
              });
              },
            ) : null
            : contentTapped ? Row(
              children: [
                Icon(Icons.subdirectory_arrow_right , color: Colors.grey,),
                SizedBox(width:15),
                Icon(Icons.subdirectory_arrow_left , color: Colors.grey,),
            ],
            )
            : null
          )
        ],
        iconTheme: IconThemeData(color: Colors.black),
        //backgroundColor: Colors.grey[50],
        elevation: 0,
      ),
       body:SingleChildScrollView(
         child: Container(
           margin: EdgeInsets.only(left:30 , right: 10),
           child: Column(
             children: [
               TextField(
                // textDirection: TextDirection.rtl,
                 cursorColor: Colors.orangeAccent,
                 style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold  ,
                 ),
                // cursorHeight: 4 ,
                // controller: titleController,
                 decoration: InputDecoration(
                   border: InputBorder.none,
                   enabledBorder: InputBorder.none ,
                   errorBorder: InputBorder.none,
                   focusedBorder: InputBorder.none,
                   hintText: 'Title' ,
                   hintStyle: TextStyle(
                     color: Colors.grey ,
                     fontSize: 20 ,
                     fontWeight: FontWeight.bold
                   ),
                 ),
                 onChanged: (value){
                   setState(() {
                     title = value ;
                   });
                 },
                 onTap: (){
                   setState(() {
                     titleTapped = true ;
                   });
                 },
               ),
               TextField(
                 cursorColor: Colors.orangeAccent,
                 style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold ),
                 maxLines: 30,
                // controller: contentController,
                 decoration: InputDecoration(
                   border: //OutlineInputBorder()
                   InputBorder.none
                 ),
                 onChanged: (value){
                   content = value ;
                 },
                 onTap: (){
                   setState(() {
                     contentTapped = true ;
                   });
                 },
                 
               ),
             ],
           ),
         ),
       ),  
    );
  }
}