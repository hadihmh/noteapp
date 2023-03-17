import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:my_first_co_app/firestore_db.dart';
import 'package:my_first_co_app/note.dart';
import 'package:my_first_co_app/utils/enums.dart';

class NoteController extends GetxController {
  Rx<List<Note>> noteList = Rx<List<Note>>([]);
  List<Note> get notes => noteList.value;
  RxBool showContent = true.obs;
  RxBool showEditAndDelete = false.obs;

  @override
  void onReady() {
    noteList.bindStream(FirestoreDb.noteStream());
  }

  showContentOfNote() {
    showContent(!showContent.value);
  }

  showEditAndDeletOfNote(int index) {
    noteList.value[index].editable = (!noteList.value[index].editable);
  }

  String appBarTitle(appBarAddNote appBarTitle) {
    String title = "";
    switch (appBarTitle) {
      case appBarAddNote.add:
        title = "Add Note";
        break;
      case appBarAddNote.edit:
        title = "Edit Note";
        break;
      case appBarAddNote.view:
        title = "View Note";
        break;
    }
    return title;
  }
}
