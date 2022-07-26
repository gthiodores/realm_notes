import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm_notes/data/model/user.dart';
import 'package:realm_notes/injector.dart';
import 'package:realm_notes/presentation/bloc/note/edit/note_edit_bloc.dart';
import 'package:realm_notes/presentation/route/note/edit/note_edit_wireframe.dart';
import 'package:realm_notes/presentation/util/note_colour.dart';
import 'package:realm_notes/presentation/widget/note_colour_item.dart';

// TODO: WIP EDIT FUNCTIONALITY!
class NoteEditRoute extends StatelessWidget {
  static const String route = '/edit';

  final Notes? note;

  const NoteEditRoute({Key? key, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteEditBloc(injector.get(), note: note),
      child: BlocConsumer<NoteEditBloc, NoteEditState>(
        listener: (context, state) {
          if (state.shouldNavigateBack) Navigator.pop(context);
        },
        builder: (context, state) {
          final color = state.currentColour == null
              ? Colors.white
              : state.currentColour!.color;

          return WillPopScope(
            onWillPop: () async {
              if (!state.hasChanged) return true;

              final result = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: Text(
                    'Discard Changes?',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  content: const Text(
                    'Changes you have made will not be saved, go back anyway?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('No'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              );

              return result ?? false;
            },
            child: Scaffold(
              backgroundColor: color,
              body: NoteEditWireframe(
                color: color,
                title: Text(note == null ? 'Add note' : 'Edit note'),
                onCloseTap: () => Navigator.maybePop(context),
                onSaveTap: () =>
                    context.read<NoteEditBloc>().add(NoteEditConfirm()),
                titleTextField: TextFormField(
                  initialValue: note?.title,
                  onChanged: (title) => context
                      .read<NoteEditBloc>()
                      .add(NoteEditTitle(title: title)),
                  style: Theme.of(context).textTheme.headline6,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
                contentTextField: TextFormField(
                  initialValue: note?.content,
                  onChanged: (content) => context
                      .read<NoteEditBloc>()
                      .add(NoteEditContent(content: content)),
                  decoration: const InputDecoration(
                    hintText: 'Insert notes here',
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                color: Colors.black,
                child: SizedBox(
                  height: 48 + 16,
                  child: Row(
                    children: [
                      NoteColourItem(
                        backgroundColor: Colors.white,
                        selected: state.currentColour == null,
                        onTap: () => context
                            .read<NoteEditBloc>()
                            .add(const NoteEditColour()),
                      ),
                      ...NoteColour.values
                          .map((colour) => NoteColourItem(
                                backgroundColor: colour.color,
                                selected: state.currentColour == colour,
                                onTap: () => context
                                    .read<NoteEditBloc>()
                                    .add(NoteEditColour(colour: colour)),
                              ))
                          .toList(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
