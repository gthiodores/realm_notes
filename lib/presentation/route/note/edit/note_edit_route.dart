import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm_notes/data/model/user.dart';
import 'package:realm_notes/injector.dart';
import 'package:realm_notes/presentation/bloc/note/edit/note_edit_bloc.dart';
import 'package:realm_notes/presentation/route/note/edit/note_edit_wireframe.dart';
import 'package:realm_notes/presentation/util/note_colour.dart';
import 'package:realm_notes/presentation/widget/note_colour_item.dart';

class NoteEditRoute extends StatefulWidget {
  static const String route = '/edit';

  final Notes? note;

  const NoteEditRoute({Key? key, this.note}) : super(key: key);

  @override
  State<NoteEditRoute> createState() => _NoteEditRouteState();
}

class _NoteEditRouteState extends State<NoteEditRoute> {
  final FocusNode contentFocusNode = FocusNode();

  @override
  void dispose() {
    contentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteEditBloc(
        injector.get(),
        injector.get(),
        injector.get(),
        note: widget.note,
      ),
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
              body: state.loading
                  ? const Center(child: CircularProgressIndicator())
                  : NoteEditWireframe(
                      color: color,
                      title:
                          Text(widget.note == null ? 'Add note' : 'Edit note'),
                      onCloseTap: () => Navigator.maybePop(context),
                      primaryActionButton: IconButton(
                        onPressed: () =>
                            context.read<NoteEditBloc>().add(NoteEditConfirm()),
                        splashRadius: 24,
                        icon: const Icon(Icons.save_alt_rounded),
                        tooltip: 'Save',
                      ),
                      secondaryActionButton: widget.note == null
                          ? null
                          : IconButton(
                              onPressed: () async => await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  title: Text(
                                    'Delete note?',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  content: const Text(
                                    'This note will be gone forever, are you sure?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('No'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: const Text('Yes'),
                                    ),
                                  ],
                                ),
                              ).then((value) {
                                if (value == true) {
                                  context
                                      .read<NoteEditBloc>()
                                      .add(NoteEditDelete());
                                }
                              }),
                              splashRadius: 24,
                              icon: const Icon(Icons.delete_outline_rounded),
                              tooltip: 'Delete',
                            ),
                      titleTextField: TextFormField(
                        initialValue: widget.note?.title,
                        onChanged: (title) => context
                            .read<NoteEditBloc>()
                            .add(NoteEditTitle(title: title)),
                        style: Theme.of(context).textTheme.headline6,
                        decoration: const InputDecoration(
                          hintText: 'Title',
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                      contentTextField: TextFormField(
                        initialValue: widget.note?.content,
                        focusNode: contentFocusNode,
                        onChanged: (content) => context
                            .read<NoteEditBloc>()
                            .add(NoteEditContent(content: content)),
                        decoration: const InputDecoration(
                          hintText: 'Insert note content here',
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                      ),
                      onSpaceTap: () {
                        if (contentFocusNode.hasFocus) {
                          contentFocusNode.unfocus();
                          return;
                        }

                        contentFocusNode.requestFocus();
                      },
                    ),
              bottomNavigationBar: BottomAppBar(
                color: Colors.black,
                child: SizedBox(
                  height: 48 + 16,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          Icons.color_lens,
                          size: 36,
                          color: color,
                        ),
                      ),
                      NoteColourItem(
                        backgroundColor: Colors.white,
                        selected: state.currentColour == null,
                        tooltip: 'white',
                        onTap: () => context
                            .read<NoteEditBloc>()
                            .add(const NoteEditColour()),
                      ),
                      ...NoteColour.values
                          .map((colour) => NoteColourItem(
                                backgroundColor: colour.color,
                                tooltip: colour.name,
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
