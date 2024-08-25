import 'package:flutter/material.dart';

import 'local_database/objectbox.dart';
import 'router_config.dart';

/// Provides access to the ObjectBox Store throughout the app.
late ObjectBox objectbox;

Future<void> main() async {
  // This is required so ObjectBox can get the application directory
  // to store the database in.
  WidgetsFlutterBinding.ensureInitialized();

  objectbox = await ObjectBox.create();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Contacts',
      debugShowCheckedModeBanner: false,
      routerConfig: routerConfig,
      builder: (context, router) {
        return router!;
      },
    );
  }
}
