import 'package:flutsocket/presentation/router/app_router.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AppRouter.userPage),
                child: const Text("User"),
              ),
              SizedBox(
                height: 100,
              ),
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AppRouter.driverPage),
                child: const Text("Driver"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
