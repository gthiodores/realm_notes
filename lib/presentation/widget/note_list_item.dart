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
    final color = _note.color == null
        ? Colors.white
        : NoteColour.values[_note.color!].color;

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Card(
        color: color,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
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
