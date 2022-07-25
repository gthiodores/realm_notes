import 'package:flutter/material.dart';
import 'package:realm_notes/data/model/user.dart';
import 'package:realm_notes/presentation/util/note_colour.dart';

class NoteListItem extends StatelessWidget {
  final VoidCallback? onTap;
  final Notes _note;

  const NoteListItem({
    Key? key,
    required Notes note,
    this.onTap,
  })  : _note = note,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Card(
        color: NoteColour.values[_note.color ?? 2].color,
        child: ListTile(
          title: Text(_note.title),
          subtitle: Text(
            _note.content,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
