interface class AuthRouteName{
  static const String loginScreen = "/login";
  static const String dashboardScreen = "/dashboard";
}

class RoutesName{
  RoutesName._();

  static const String defaultScreen = '/login';//private constructor

  static AuthRouteName get auth => AuthRouteName();//getter method
}