import 'package:flutter/material.dart';
import 'package:realm_notes/data/model/user.dart';
import 'package:realm_notes/presentation/util/note_colour.dart';

class NoteListItem extends StatelessWidget {
  final VoidCallback? onTap;
  final Notes _note;
  final int maxLines;

  const NoteListItem(
      {Key? key, required Notes note, this.onTap, this.maxLines = 4})
      : _note = note,
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
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              _note.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          subtitle: Text(
            _note.content,
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
