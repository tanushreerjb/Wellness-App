import 'package:flutter/material.dart';
import 'package:wellness_app/add_category.dart';
import 'package:wellness_app/add_quote.dart';
import 'package:wellness_app/core/route/route_name.dart';
import 'package:wellness_app/features/auth/login.dart';
import 'package:wellness_app/features/dashboard/dashboard.dart';

class RouteConfig {
  RouteConfig._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final String? screenName = settings.name;
    final dynamic arg = settings.arguments;
    final String abc = AuthRouteName.loginScreen;
    switch (screenName) {
      case AuthRouteName.dashboardScreen:
        return MaterialPageRoute(
            builder: (_) =>
                DashboardPage()
        );

      case RoutesName.defaultScreen:
      default:
        return MaterialPageRoute(builder: (_) => AddQuote()); //change this to login page later !!
    }
  }
}