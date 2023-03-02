import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_first_co_app/controllers/note_controller.dart';
import 'package:my_first_co_app/edit_screen.dart';
import 'package:my_first_co_app/firestore_db.dart';
import 'package:my_first_co_app/widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => HomeScreen());
  HomeScreen({Key? key}) : super(key: key);
  NoteController authController = Get.put(NoteController());
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          CircleAvatar(
              backgroundColor: Colors.blue.shade200,
              child: Obx(
                () => Text(
                  authController.noteList.value.length.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                ),
              )),
          const SizedBox(
            width: 10,
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.line_weight_sharp),
          onPressed: () {
            _scaffoldkey.currentState?.openDrawer();
          },
        ),
      ),
      body: Obx(
        () => ListView.separated(
          itemCount: authController.noteList.value.length,
          separatorBuilder: (context, index) => const Divider(
            color: Colors.blueGrey,
          ),
          itemBuilder: (context, index) => ListTile(
            trailing: SizedBox(
              width: 110.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      Get.to(() => EditScreen(
                            note: authController.noteList.value[index],
                          ));
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.blue,
                    ),
                    onPressed: () async {
                      await FirestoreDb.deleteNote(
                          authController.noteList.value[index].documentid ??
                              "");
                    },
                  ),
                ],
              ),
            ),
            title: Text(authController.noteList.value[index].title ?? ""),
            subtitle: Text(authController.noteList.value[index].content ?? ""),
            onTap: () {
              Get.to(() => EditScreen(
                    note: authController.noteList.value[index],
                  ));
            },
            onLongPress: () {},
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // FloatingActionButton(
          //     child: const Icon(Icons.menu),
          //     tooltip: 'Show less. Hide notes content',
          //     onPressed: () {}),

          //     /* Notes: for the "Show More" icon use: Icons.menu */

          FloatingActionButton(
            tooltip: 'Add a new note',
            onPressed: () {
              Get.to(() => EditScreen());
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
