
class Note{
  int _id ;
  String _title , _content ;

  int get id => _id ;
  String get title => _title ;
  String get content => _content ;

  Note(dynamic obj){
    _id = obj['id'] ;
    _title = obj['title'];
    _content = obj['content'];
  }

  Note.fromMap( Map<String , dynamic> data ){
    _id = data['id'] ;
    _title = data['title'];
    _content = data['content'];
  }

   Map<String , dynamic> toMap() => { 'id' : _id , 'title' : _title , 'content' : _content  };

} // end class 