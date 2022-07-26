import 'package:flutter/material.dart';

class NoteListWireframe extends StatelessWidget {
  final VoidCallback? onProfileTap;
  final VoidCallback? onSearchTap;
  final VoidCallback? onLayoutTap;
  final bool isGridLayout;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final int itemCount;

  const NoteListWireframe({
    Key? key,
    this.onProfileTap,
    this.onSearchTap,
    this.onLayoutTap,
    this.isGridLayout = false,
    required this.itemBuilder,
    required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: onLayoutTap,
              splashRadius: 24,
              iconSize: 24,
              icon: Icon(isGridLayout ? Icons.list : Icons.grid_view_rounded),
            ),
            title: const Text('Notes'),
            titleTextStyle: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
            actions: [
              IconButton(
                onPressed: onProfileTap,
                splashRadius: 24,
                iconSize: 24,
                icon: const Icon(Icons.person),
              ),
              IconButton(
                onPressed: onSearchTap,
                splashRadius: 24,
                icon: const Icon(Icons.search),
              ),
            ],
            snap: true,
            floating: true,
            forceElevated: true,
          ),
          if (isGridLayout) ...[
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                itemBuilder,
                childCount: itemCount,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
            ),
          ] else ...[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                itemBuilder,
                childCount: itemCount,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
