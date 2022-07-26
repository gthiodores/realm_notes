import 'package:flutter/material.dart';

class NoteColourItem extends StatelessWidget {
  final Color backgroundColor;
  final bool selected;
  final VoidCallback? onTap;

  const NoteColourItem({
    Key? key,
    required this.backgroundColor,
    required this.selected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ClipOval(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          color: backgroundColor,
          width: selected ? 48 : 32,
          height: selected ? 48 : 32,
          alignment: Alignment.center,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: selected
                  ? const Center(child: Icon(Icons.check, size: 24))
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
