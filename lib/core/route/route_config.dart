import 'package:flutter/material.dart';
import 'package:wellness_app/add_category.dart';
import 'package:wellness_app/add_quote.dart';
import 'package:wellness_app/features/dashboard/admin_dashboard.dart';
import 'package:wellness_app/health_tips.dart';
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

      case AuthRouteName.addQuoteScreen:
        return MaterialPageRoute(
            builder: (_) =>
                AddQuote()
        );

      case AuthRouteName.addCategoryScreen:
        return MaterialPageRoute(
            builder: (_) =>
                AddCategory()
        );

      case AuthRouteName.healthTipsScreen:
        return MaterialPageRoute(
            builder: (_) =>
                HealthTips()
        );

      case AuthRouteName.adminDashboardScreen:
        return MaterialPageRoute(
            builder: (_) =>
                AdminDashboard()
        );



      case RoutesName.defaultScreen:
      default:
        return MaterialPageRoute(builder: (_) => AdminDashboard()); //change this to login page later !!
    }
  }
}