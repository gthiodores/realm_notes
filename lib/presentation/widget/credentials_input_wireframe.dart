import 'package:flutter/material.dart';

class CredentialsInputWireframe extends StatelessWidget {
  final Widget title;
  final Widget fieldUsername;
  final Widget fieldPassword;
  final Widget actionButton;
  final Widget forgotPassword;

  const CredentialsInputWireframe({
    Key? key,
    required this.title,
    required this.fieldPassword,
    required this.fieldUsername,
    required this.actionButton,
    required this.forgotPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: title,
              ),
              const SizedBox(height: 24),
              fieldUsername,
              const SizedBox(height: 16),
              fieldPassword,
              const SizedBox(height: 16),
              actionButton,
              forgotPassword,
            ],
          ),
        ),
      ),
    );
  }
}
