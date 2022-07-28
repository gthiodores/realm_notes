import 'package:flutter/material.dart';

class NoteEditWireframe extends StatelessWidget {
  final VoidCallback? onCloseTap;
  final VoidCallback? onSpaceTap;
  final Color color;
  final Widget title;
  final Widget titleTextField;
  final Widget contentTextField;
  final Widget primaryActionButton;
  final Widget? secondaryActionButton;

  const NoteEditWireframe({
    Key? key,
    this.onCloseTap,
    this.onSpaceTap,
    required this.color,
    required this.title,
    required this.titleTextField,
    required this.contentTextField,
    required this.primaryActionButton,
    this.secondaryActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: [
        SliverAppBar(
          title: title,
          titleTextStyle: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: Colors.black),
          centerTitle: true,
          leading: IconButton(
            onPressed: onCloseTap,
            splashRadius: 24,
            icon: const Icon(Icons.close),
          ),
          snap: true,
          floating: true,
          actions: [
            secondaryActionButton ?? Container(),
            primaryActionButton,
          ],
          backgroundColor: color,
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          sliver: SliverToBoxAdapter(child: titleTextField),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          sliver: SliverToBoxAdapter(child: contentTextField),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: GestureDetector(onTap: onSpaceTap),
        ),
      ],
    );
  }
}
