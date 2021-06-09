import 'package:flutter/material.dart';
import 'package:note_pad/database/databaseHelper.dart';
import 'package:note_pad/models/note.dart';

import 'home.dart';

class NoteUpdate extends StatefulWidget {

  Note note ;
  NoteUpdate(this.note); 

  @override
  _NoteUpdateState createState() => _NoteUpdateState();
}

class _NoteUpdateState extends State<NoteUpdate> {

  
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  String title = '' ;
  String  content = '';
  bool titleTapped = false ;
  bool contentTapped = false ;
  DbHelper helper ;

  @override
  void initState() {
    super.initState();
    helper = DbHelper();
    titleController.text = widget.note.title;
    contentController.text = widget.note.content ;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,

         actions: [
          Container(
            margin: EdgeInsets.only( right: 20 ,),
            child: titleTapped ? title.isNotEmpty ?  
            IconButton(icon: Icon( Icons.done ,size: 25,), onPressed: () async{
              Note note = Note({ 'id': widget.note.id, 'title':titleController.text , 'content' : contentController.text });
               await helper.updateNote(note);
               Navigator.of(context).pop();
             // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
            }) : null
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
                 controller: titleController,
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
               Container(
                 margin: EdgeInsets.only(right:10),
                 child: TextField(
                   //textDirection: TextDirection.rtl,
                   cursorColor: Colors.orangeAccent,
                   style: TextStyle(fontSize: 18 , ),
                   maxLines: 30,
                   controller: contentController,
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
               ),
             ],
           ),
         ),
       ),
    );
  }
}