import 'package:contacts_with_sqlite/controllers/contacts_controller.dart';
import 'package:contacts_with_sqlite/models/contact.dart';
import 'package:contacts_with_sqlite/views/screens/contact_info_screen.dart';
import 'package:contacts_with_sqlite/views/screens/contacts_screen.dart';
import 'package:contacts_with_sqlite/views/screens/create_contact_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contacts',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return _buildRoute(settings, const ContactsScreen());
          case '/create':
            return _buildRoute(
              settings,
              CreateContactScreen(
                contactsController: settings.arguments as ContactsController,
              ),
            );
          case '/info':
            return _buildRoute(
                settings,
                ContactInfoScreen(
                  contact: settings.arguments as Contact,
                ));
          default:
            return null;
        }
      },
    );
  }

  PageRouteBuilder _buildRoute(RouteSettings settings, Widget page) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
