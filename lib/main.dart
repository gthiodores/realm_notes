import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realm_notes/injector.dart';
import 'package:realm_notes/presentation/route/login/login_route.dart';
import 'package:realm_notes/presentation/route/note/edit/note_edit_route.dart';
import 'package:realm_notes/presentation/route/note/list/note_list_route.dart';
import 'package:realm_notes/presentation/theme/theme.dart';

import 'presentation/route/register/register_route.dart';

void main() {
  injectDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: kColorScheme,
        appBarTheme: kAppBarTheme,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.aBeeZeeTextTheme(),
        elevatedButtonTheme: kElevatedButtonTheme,
        textButtonTheme: kTextButtonTheme,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginRoute(),
      onGenerateRoute: (setting) {
        switch (setting.name) {
          case LoginRoute.route:
            return PageRouteBuilder(
              pageBuilder: (context, anim, secondary) => const LoginRoute(),
              transitionsBuilder: (context, animation, secondary, child) {
                final curveTween = CurveTween(curve: Curves.ease);
                final tween = Tween(begin: 0.0, end: 1.0).chain(curveTween);
                final transition = animation.drive(tween);
                return FadeTransition(opacity: transition, child: child);
              },
            );
          case RegisterRoute.route:
            return PageRouteBuilder(
              pageBuilder: (context, anim, secondary) => const RegisterRoute(),
              transitionsBuilder: (context, animation, secondary, child) {
                final curveTween = CurveTween(curve: Curves.ease);

                const offsetStart = Offset(1, 0);
                const offsetEnd = Offset(0, 0);

                final tween =
                    Tween(begin: offsetStart, end: offsetEnd).chain(curveTween);
                final transition = animation.drive(tween);

                return SlideTransition(position: transition, child: child);
              },
            );
          case NoteListRoute.route:
            return PageRouteBuilder(
              pageBuilder: (context, anim, secondary) => const NoteListRoute(),
              transitionsBuilder: (context, animation, secondary, child) {
                final curveTween = CurveTween(curve: Curves.ease);
                final tween = Tween(begin: 0.0, end: 1.0).chain(curveTween);
                final transition = animation.drive(tween);
                return FadeTransition(opacity: transition, child: child);
              },
            );
          case NoteEditRoute.route:
            return PageRouteBuilder(
              pageBuilder: (context, anim, secondary) => const NoteEditRoute(),
              transitionsBuilder: (context, animation, secondary, child) {
                final curveTween = CurveTween(curve: Curves.ease);

                const offsetStart = Offset(0, 1);
                const offsetEnd = Offset(0, 0);

                final tween =
                    Tween(begin: offsetStart, end: offsetEnd).chain(curveTween);
                final transition = animation.drive(tween);

                return SlideTransition(position: transition, child: child);
              },
            );
          default:
            return MaterialPageRoute(
              builder: (context) => const Center(child: Text('Unknown Route')),
            );
        }
      },
    );
  }
}
