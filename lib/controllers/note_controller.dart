import 'package:get/get.dart';
import 'package:my_first_co_app/firestore_db.dart';
import 'package:my_first_co_app/note.dart';

class NoteController extends GetxController {
  Rx<List<Note>> noteList = Rx<List<Note>>([]);
  List<Note> get notes => noteList.value;

  @override
  void onReady() {
    noteList.bindStream(FirestoreDb.noteStream());
  }
}
