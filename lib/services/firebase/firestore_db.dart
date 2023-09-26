import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:live_location_app/services/firebase/firebase_auth_constants.dart';

class FirestoreDb {
  static addTodo() async {
    await firebaseFirestore
        .collection('')
        .doc(auth.currentUser!.uid)
        .collection('')
        .add({
      // 'id': FieldValue.increment(1),
      'content': "",
      'title': "",
      'createdon': Timestamp.now(),
    });
  }

  static Stream<List<String>> noteStream() {
    return firebaseFirestore
        .collection('')
        .doc(auth.currentUser!.uid)
        .collection('')
        .snapshots()
        .map((QuerySnapshot query) {
      List<String> notes = [];

      return notes;
    });
  }

  static updateStatus() {
    firebaseFirestore
        .collection('')
        .doc(auth.currentUser!.uid)
        .collection('')
        .doc("")
        .update(
      {
        'content': "",
        'title': "",
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
