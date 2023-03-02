import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_first_co_app/firebase_auth_constants.dart';
import 'package:my_first_co_app/note.dart';

class FirestoreDb {
  static addTodo(Note noteModel) async {
    await firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('notes')
        .add({
      // 'id': FieldValue.increment(1),
      'content': noteModel.content,
      'title': noteModel.title,
      'createdon': Timestamp.now(),
    });
  }

  static Stream<List<Note>> noteStream() {
    return firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('notes')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Note> notes = [];
      for (var todo in query.docs) {
        final note = Note.fromDocumentSnapshot(documentSnapshot: todo);
        notes.add(note);
      }
      return notes;
    });
  }

  static updateStatus(Note noteModel) {
    firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('notes')
        .doc(noteModel.documentid)
        .update(
      {
        'content': noteModel.content,
        'title': noteModel.title,
        'createdon': Timestamp.now(),
      },
    );
  }

  static deleteNote(String documentId) {
    firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('notes')
        .doc(documentId)
        .delete();
  }
}
