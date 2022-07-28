import 'package:equatable/equatable.dart';
import 'package:realm/realm.dart';
import 'package:realm_notes/data/model/user.dart';

class DomainNote extends Equatable {
  final ObjectId id;
  final String title;
  final String content;
  final String holder;
  final int? color;

  const DomainNote({
    required this.id,
    required this.title,
    required this.content,
    required this.holder,
    this.color,
  });

  factory DomainNote.fromNotes(Notes note) => DomainNote(
        id: note.id,
        title: note.title,
        content: note.content,
        holder: note.holder,
        color: note.color,
      );

  Notes toNotes() => Notes(
        id,
        title,
        content,
        holder,
        color: color,
      );

  @override
  List<Object?> get props => [id, title, content, holder, color];
}
