import 'package:flutter/material.dart';
import 'package:wellness_app/features/users/admin/screens/add_category.dart';
import 'package:wellness_app/features/users/admin/screens/add_quote.dart';
import 'package:wellness_app/features/dashboard/admin_dashboard.dart';
import 'package:wellness_app/features/users/admin/screens/health_tips.dart';
import 'package:wellness_app/core/route/route_name.dart';
import 'package:wellness_app/features/auth/login.dart';
import 'package:wellness_app/features/dashboard/customer_dashboard.dart';
import 'package:wellness_app/features/users/customer/screens/user_preference.dart';

import '../../features/users/admin/screens/add_category.dart';

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
                AddQuote(userId: '',)
        );

      case AuthRouteName.addCategoryScreen:
        return MaterialPageRoute(
            builder: (_) =>
                AddCategory(userId: '',)
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

      case AuthRouteName.userPreferenceScreen:
        return MaterialPageRoute(
            builder: (_) =>
                UserpreferencePage()
        );



      case RoutesName.defaultScreen:
      default:
        return MaterialPageRoute(builder: (_) => LoginPage()); //change this to login page later !!
    }
  }
}