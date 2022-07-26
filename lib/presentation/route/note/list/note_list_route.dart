import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm_notes/injector.dart';
import 'package:realm_notes/presentation/bloc/note/list/note_list_bloc.dart';
import 'package:realm_notes/presentation/route/note/detail/note_detail_route.dart';
import 'package:realm_notes/presentation/route/note/edit/note_edit_route.dart';
import 'package:realm_notes/presentation/route/note/list/note_list_wireframe.dart';
import 'package:realm_notes/presentation/widget/note_list_item.dart';

class NoteListRoute extends StatelessWidget {
  static const String route = '/notes';

  const NoteListRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NoteListBloc(watchNotes: injector.get())..add(NoteListInit()),
      child: Scaffold(
        body: BlocConsumer<NoteListBloc, NoteListState>(
          listener: (context, state) {
            print('State has changed: $state');
          },
          builder: (context, state) {
            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            return NoteListWireframe(
              itemBuilder: (context, index) {
                if (state.notes.isEmpty) {
                  return const ListTile(
                    title: Text("You don't have a note yet."),
                  );
                }

                if (index == state.notes.length) {
                  return const SizedBox(height: 56 + 16);
                }

                return NoteListItem(
                  note: state.notes[index],
                  onTap: () => Navigator.pushNamed(
                    context,
                    NoteDetailRoute.route,
                    arguments: state.notes[index],
                  ),
                );
              },
              itemCount: state.notes.length + 1,
              isGridLayout: state.grid,
              onLayoutTap: () =>
                  context.read<NoteListBloc>().add(NoteListChangeLayout()),
              onProfileTap: () => print('profile'),
              onSearchTap: () => print('search'),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async =>
              await Navigator.pushNamed(context, NoteEditRoute.route)
                  .then((value) {
            if (value != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Note added!')),
              );
            }
          }),
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
