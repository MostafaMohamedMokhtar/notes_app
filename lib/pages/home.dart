import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_pad/database/databaseHelper.dart';
import 'package:note_pad/models/note.dart';
import 'package:note_pad/pages/add_note.dart';
import 'package:note_pad/pages/noteUpdate.dart';
import 'package:provider/provider.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  DbHelper helper ;
  //bool langEnglish = true;
  bool deletedItem = false ;
  var allNotes = [] ;
  var items = [] ;
  TextEditingController serchControll = TextEditingController();
  @override
  void initState() {
    super.initState();
      helper = DbHelper();
      helper.getAllNotes().then( (notes){
          setState(() {
            allNotes = notes ;
            items = allNotes ;
          });
        });
  }
  Future<List<dynamic>> getNotes() async{
    helper.getAllNotes().then( (notes){
          setState(() {
            allNotes = notes ;
            items = allNotes ;
          });
        });
        return items ;
  }
  void filterSearch( String query) async{
    var dummySearchList = allNotes;
    if(query.isNotEmpty){
      var dummyListData = List() ;
      dummySearchList.forEach((item) { 
        var note = Note.fromMap(item) ;
        if(note.title.toLowerCase().contains(query.toLowerCase()) || 
           note.content.toLowerCase().contains(query.toLowerCase())){
           dummyListData.add(item) ;
        }
      }) ;
      setState(() {
        items = [] ;
        items.addAll(dummyListData);
      });
      return ;
    }
    else{
      setState(() {
        items = [] ;
        items = allNotes ;
      });
    }
  } // end filterSearch()

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
         appBar: AppBar(
    actions: [
      Container(
        margin: EdgeInsets.only(right:10),
        child: IconButton(
          icon: Icon(Icons.more_vert , color: Colors.black,), 
          onPressed: (){}
          ),
      )
    ],
    elevation: 0,
    ),
        body: Stack(
    children: [ 
      SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height ,
         // margin: EdgeInsets.only(top:90),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(    
                  controller: serchControll, 
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left:5),
                    icon: Padding(
                      padding: const EdgeInsets.only(left:20),
                      child: Icon(Icons.search , color: Colors.grey,),
                    ),
                   // prefixIcon: Icon(Icons.search) ,
                    hintText: 'Search notes' ,
                    hintStyle: TextStyle(fontSize: 18 , color: Colors.grey ) ,
                    border:InputBorder.none
                  ),
                  onChanged: (value){
                    setState(() {
                      filterSearch(value);
                    });
                  },
                ),
              ) ,
              SizedBox(height:20),
            /*   Consumer<DbHelper>(builder:(BuildContext context , DbHelper dbHelper , child){
                return Expanded(
                child: StaggeredGridView.countBuilder(
               crossAxisCount: 2,
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(), 
               itemCount: items.length,
               staggeredTileBuilder: (index) => new StaggeredTile.fit(1),
               mainAxisSpacing: 10,
               crossAxisSpacing: 10,
               padding: EdgeInsets.symmetric(horizontal: 10 ),
               itemBuilder: (context , index){
                 Note note =  Note.fromMap(items[index]) ;
                 return Container(
                   decoration:BoxDecoration(
                     borderRadius: BorderRadius.circular(15) ,
                     color: Colors.white ,
                   ) ,
                   height: 150,
                   child: InkWell(
                     onLongPress: (){
                       print('deleted') ;
                      setState(() {
                        deletedItem = true ;
                       showAlertDialog(context, note);
                      });
                     },
                     onTap: (){
                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=> NoteUpdate(note)));
                     },
                     child: ClipRRect(  
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                  children: [
                      Text('${note.title}' ,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                         color: Colors.black , fontSize: 16 , fontWeight: FontWeight.bold ,
                         fontStyle: FontStyle.italic ,
                       ),),
                      SizedBox(height:8),
                      Expanded(
                        child: Text(
                          '${note.content}' ,
                          textDirection: TextDirection.rtl,
                       style: TextStyle(
                         color: Colors.black54 , fontSize: 16 , fontStyle: FontStyle.italic
                       ),
                       )
                       ),
                  ],),
                ) ,
              ),
                   ),
                 ) ;
               }, 
               )
                ) ;
              }), */
              
              FutureBuilder(
                future: getNotes(),
                builder: (context , AsyncSnapshot snapshot){
                  if( !snapshot.hasData){
                    return CircularProgressIndicator() ;
                  }
                  else {
                   return   StaggeredGridView.countBuilder(
               crossAxisCount: 2,
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(), 
               itemCount: items.length,
               staggeredTileBuilder: (index) => new StaggeredTile.fit(1),
               mainAxisSpacing: 10,
               crossAxisSpacing: 10,
               padding: EdgeInsets.symmetric(horizontal: 10 ),
               itemBuilder: (context , index){
                 Note note =  Note.fromMap(items[index]) ;
                 return Container(
                   decoration:BoxDecoration(
                     borderRadius: BorderRadius.circular(15) ,
                     color: Colors.white ,
                   ) ,
                   height: 150,
                   child: InkWell(
                     onLongPress: (){
                       print('deleted') ;
                      setState(() {
                        deletedItem = true ;
                       showAlertDialog(context, note);
                      });
                     },
                     onTap: (){
                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=> NoteUpdate(note)));
                     },
                     child: ClipRRect(  
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                  children: [
                      Text('${note.title}' ,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                         color: Colors.black , fontSize: 16 , fontWeight: FontWeight.bold ,
                         fontStyle: FontStyle.italic ,
                       ),),
                      SizedBox(height:8),
                      Expanded(
                        child: Text(
                          '${note.content}' ,
                          textDirection: TextDirection.rtl,
                       style: TextStyle(
                         color: Colors.black54 , fontSize: 16 , fontStyle: FontStyle.italic
                       ),
                       )
                       ),
                  ],),
                ) ,
              ),
                   ),
                 ) ;
               }, 
               );
                  }
                }
                ),
            ],
          ),
        ),
      ),
     Positioned(
        right: 20,
        bottom: 30,
        child: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddNote()));
          },
          child: Icon(Icons.add , size: 35,),
          backgroundColor: Colors.amber,
          foregroundColor: Colors.white,
        ),
      ),
    ],
        ),
      );
  }
  showAlertDialog(BuildContext context , Note note) {

  // set up the button
 /*  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      setState(() {
        helper.deleteNote(note.id);
        Navigator.of(context).pop();
        //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
      });
     },
  ); */

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(  
    
    title: Text("Deleted"),
    content: Text("Are tou sure to delete ..."),
    actions: [
     // okButton,
     Consumer(
       builder: (context , DbHelper dbHelper , child){
         return FlatButton(
    child: Text("OK"),
    onPressed: () {
      setState(() {
        dbHelper.deleteNote(note.id);
        Navigator.of(context).pop();
        //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
      });
     },
  ) ;
       }
       ) ,
    ],
    elevation: 1,
    shape: RoundedRectangleBorder
    (borderRadius: BorderRadius.circular(20.0)
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
} // end showAlertDialog

 Widget changeColorOfQuery(String query){
   return Text('$query' , style: TextStyle(color: Colors.orange),);
 }

} // end class 