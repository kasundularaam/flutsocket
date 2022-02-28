import 'package:flutsocket/logic/cubit/get_location_cubit/get_location_cubit.dart';
import 'package:flutsocket/logic/cubit/send_location_cubit/send_location_cubit.dart';
import 'package:flutsocket/presentation/screens/driver_screen/driver_page.dart';
import 'package:flutsocket/presentation/screens/user_screen/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/exceptions/route_exception.dart';
import '../screens/home_screen/home_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String userPage = '/userPage';
  static const String driverPage = '/driverPage';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case userPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => GetLocationCubit(),
            child: const UserPage(),
          ),
        );
      case driverPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SendLocationCubit(),
            child: const DriverPage(),
          ),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
