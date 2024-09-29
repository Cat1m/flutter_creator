import 'package:flutter/material.dart';
import 'package:sample_flutter/services/splash/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    splashServices.checkAuthentication(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          textAlign: TextAlign.center,
          'Chào bạn đến với Sample\ncủa Chiến ^_^',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
