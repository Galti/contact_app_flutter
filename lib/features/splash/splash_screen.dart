import 'package:contact_app_flutter/router_config.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Contacts ...'),
      ),
    );
  }

  void initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    if (context.mounted) {
      const DashboardRoute().replace(context);
    }
  }
}
