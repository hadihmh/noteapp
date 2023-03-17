import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:my_first_co_app/controllers/note_controller.dart';
import 'package:my_first_co_app/firestore_db.dart';
import 'package:my_first_co_app/note.dart';
import 'package:my_first_co_app/utils/enums.dart';

class EditScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const EditScreen());
  final Note? note;
  final appBarAddNote? appBarType;

  const EditScreen({
    Key? key,
    this.note,
    this.appBarType,
  }) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  NoteController noteController = Get.put(NoteController());
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _titleController.text = widget.note?.title ?? "";
    _descriptionController.text = widget.note?.content ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        title: Text(noteController
            .appBarTitle(widget.appBarType ?? appBarAddNote.view)),
        actions: [
          widget.appBarType != appBarAddNote.view
              ? IconButton(
                  icon: const Icon(
                    Icons.check_circle,
                    size: 30,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final Note note = Note(
                          content: _descriptionController.text.trim(),
                          title: _titleController.text.trim(),
                          documentid: widget.note?.documentid);
                      if (widget.note == null) {
                        await FirestoreDb.addTodo(note);
                        _titleController.clear();
                        _descriptionController.clear();
                        Get.back();
                      } else {
                        await FirestoreDb.updateStatus(note);
                        _titleController.clear();
                        _descriptionController.clear();
                        Get.back();
                      }
                    }
                  })
              : Container(),
          IconButton(
              icon: const Icon(
                Icons.cancel_sharp,
                size: 30,
              ),
              onPressed: () {
                Get.back();
              }),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                initialValue: null,
                enabled: widget.appBarType != appBarAddNote.view,
                decoration: const InputDecoration(
                  hintText: 'Type the title here',
                ),
                onChanged: (value) {},
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: TextFormField(
                    controller: _descriptionController,
                    enabled: widget.appBarType != appBarAddNote.view,
                    initialValue: null,
                    maxLines: null,
                    expands: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Type the description',
                    ),
                    onChanged: (value) {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
