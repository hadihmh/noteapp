import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String? documentid;
  String? title;
  String? content;

  Note({this.documentid, this.title = '', this.content = ''});

  Note.fromJson(Map<String, dynamic> json)
      : this(
            documentid: json['id'],
            title: json['title'],
            content: json['content']);

  Map<String, dynamic> toJson() =>
      {'id': documentid, 'title': title, 'content': content};

  Note.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    documentid = documentSnapshot.id;
    content = documentSnapshot["content"];
    title = documentSnapshot["title"];
  }
}
