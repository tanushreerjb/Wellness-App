interface class AuthRouteName{
  static const String loginScreen = "/login";
  static const String dashboardScreen = "/dashboard";
  static const String addQuoteScreen = "/add_quote";
  static const String addCategoryScreen = "/add_category";
  static const String healthTipsScreen = "/health_tips";
}

class RoutesName{
  RoutesName._();

  static const String defaultScreen = '/login';//private constructor

  static AuthRouteName get auth => AuthRouteName();//getter method
}