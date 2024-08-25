import 'package:flutter/material.dart';

import 'router_config.dart';

void main() {
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
