import 'package:flutter/material.dart';
import 'package:realm_notes/data/model/user.dart';
import 'package:realm_notes/presentation/route/note/edit/note_edit_wireframe.dart';
import 'package:realm_notes/presentation/util/note_colour.dart';

// TODO: WIP!
class NoteEditRoute extends StatelessWidget {
  static const String route = '/edit';

  final Notes? note;

  const NoteEditRoute({Key? key, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: note?.color == null
            ? Colors.white
            : NoteColour.values[note?.color ?? 0].color,
        body: NoteEditWireframe(
          title: Text(note == null ? 'Add note' : 'Edit note'),
          onCloseTap: () => print('close'),
          onSaveTap: () => print('save'),
          titleTextField: TextFormField(
            initialValue: note?.title,
            style: Theme.of(context).textTheme.headline6,
            decoration: const InputDecoration(
              hintText: 'Title',
              border: UnderlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
          contentTextField: TextFormField(
            initialValue: note?.content,
            decoration: const InputDecoration(
              hintText: 'Insert notes here',
              border: UnderlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.black,
          height: 48,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: NoteColour.values
                .map((e) => IconButton(
                      splashRadius: 32,
                      onPressed: () => print(e.name),
                      icon: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: e.color),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
