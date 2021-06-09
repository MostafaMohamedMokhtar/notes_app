
import 'package:flutter/widgets.dart';
import 'package:note_pad/models/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper extends ChangeNotifier{

   static final  DbHelper _instance = DbHelper.internal() ;
   factory DbHelper() => _instance ;
   DbHelper.internal() ;
   
   static Database _db ;

   Future<Database> createDatabase() async {
     if(_db != null){
       return _db ;
     }
       String path = join( await getDatabasesPath() , 'notes.db') ;
       _db = await openDatabase(path , version: 1 , onCreate: (Database db , int v ){
         // create tables 
         db.execute('CREATE TABLE Notes(id integer primary key autoincrement , title varchar(100) , content varchar(600) )');
         
       });
       return _db ;
   } // end createDatabase()

   Future<int> insertNote(Note note) async{
     Database db = await createDatabase() ;
     notifyListeners();
     return await db.insert('Notes', note.toMap()) ;
   } // end insertNote()

   Future<List> getAllNotes() async{
     Database db = await createDatabase() ;
     notifyListeners();
     return await db.query('Notes') ;
   } // end getAllNotes()

   Future<int> deleteNote(int id ) async{
     Database db = await createDatabase() ;
     notifyListeners();
     return await db.delete('Notes' , where: 'id = ? ' , whereArgs:[id] );
   } // end deleteNote()

   Future<int> updateNote(Note note) async{
     Database db = await createDatabase() ;
     notifyListeners();
     return await db.update('Notes', note.toMap() , where: 'id = ? ' , whereArgs: [note.id]);
   } // end updateNote()

} // end class 