import 'package:flutter/material.dart';

class RegisterBottomBar extends StatelessWidget {
  final VoidCallback? onRegisterTap;

  const RegisterBottomBar({Key? key, this.onRegisterTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'New Here?',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(width: 2),
            TextButton(
              onPressed: onRegisterTap,
              child: Text(
                'Register!',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
