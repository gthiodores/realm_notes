import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm_notes/injector.dart';
import 'package:realm_notes/presentation/bloc/note/search/note_search_bloc.dart';
import 'package:realm_notes/presentation/route/note/edit/note_edit_route.dart';
import 'package:realm_notes/presentation/widget/note_list_item.dart';

class NoteSearchRoute extends StatelessWidget {
  static const String route = '/search';

  const NoteSearchRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => NoteSearchBloc(searchNote: injector.get()),
        child: BlocBuilder<NoteSearchBloc, NoteSearchState>(
          builder: (context, state) => CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverAppBar(
                title: TextFormField(
                  onChanged: (content) => context
                      .read<NoteSearchBloc>()
                      .add(NoteSearchQueryChanged(query: content)),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Search notes',
                    prefixIcon: Hero(
                      tag: 'search_icon',
                      child: Icon(Icons.search, color: Colors.black),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
                floating: true,
                snap: true,
              ),
              if (state.searchQuery.isEmpty) ...[
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text('Type in search bar to begin searching'),
                  ),
                ),
              ] else if (state.loading) ...[
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
                )
              ] else ...[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => NoteListItem(
                      note: state.notes[index],
                      onTap: () => Navigator.pushNamed(
                        context,
                        NoteEditRoute.route,
                        arguments: state.notes[index],
                      ),
                    ),
                    childCount: state.notes.length,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
