import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_first_co_app/controllers/note_controller.dart';
import 'package:my_first_co_app/edit_screen.dart';
import 'package:my_first_co_app/firestore_db.dart';
import 'package:my_first_co_app/utils/enums.dart';
import 'package:my_first_co_app/widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => HomeScreen());
  HomeScreen({Key? key}) : super(key: key);
  NoteController noteController = Get.put(NoteController());
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          key: _scaffoldkey,
          drawer: CustomDrawer(),
          appBar: AppBar(
            title: const Text('My Notes'),
            actions: [
              CircleAvatar(
                  backgroundColor: Colors.blue.shade200,
                  child: Obx(
                    () => Text(
                      noteController.noteList.value.length.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.0),
                    ),
                  )),
              const SizedBox(
                width: 10,
              ),
            ],
            leading: IconButton(
              icon: const Icon(Icons.line_weight_sharp),
              onPressed: () {
                _scaffoldkey.currentState?.openDrawer();
              },
            ),
          ),
          body: ListView.separated(
            itemCount: noteController.noteList.value.length,
            separatorBuilder: (context, index) => const Divider(
              color: Colors.blueGrey,
            ),
            itemBuilder: (context, index) => ListTile(
              trailing: SizedBox(
                width: 110.0,
                child: Obx(
                  () => Visibility(
                    visible: noteController.noteList.value[index].editable,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Get.to(() => EditScreen(
                                note: noteController.noteList.value[index],
                                appBarType: appBarAddNote.edit));
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.blue,
                          ),
                          onPressed: () async {
                            await FirestoreDb.deleteNote(noteController
                                    .noteList.value[index].documentid ??
                                "");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              title: Text(noteController.noteList.value[index].title ?? ""),
              subtitle: Obx(
                () => Visibility(
                    visible: noteController.showContent.value,
                    child: Text(
                        noteController.noteList.value[index].content ?? "")),
              ),
              onTap: () {
                Get.to(() => EditScreen(
                    note: noteController.noteList.value[index],
                    appBarType: appBarAddNote.view));
              },
              onLongPress: () {
                noteController.showEditAndDeletOfNote(index);
                noteController.noteList.refresh();
              },
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                  heroTag: "showcontent",
                  tooltip: 'Show less. Hide notes content',
                  onPressed: () {
                    noteController.showContentOfNote();
                  },
                  child: noteController.showContent.value
                      ? const Icon(Icons.unfold_less)
                      : const Icon(Icons.menu)),

              //     /* Notes: for the "Show More" icon use: Icons.menu */

              FloatingActionButton(
                heroTag: "add",
                tooltip: 'Add a new note',
                onPressed: () {
                  Get.to(() => const EditScreen(appBarType: appBarAddNote.add));
                },
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ));
  }
}
