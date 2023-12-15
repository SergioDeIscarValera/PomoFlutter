enum Routes {
  SPLASH,
  FIRST_TIME,
  LOGIN,
  LOGIN_EMAIL,
  REGISTER,
  FORGOT_PASSWORD,
  HOME,
  EMAIL_VERIFICATION,
}

extension RoutesPath on Routes {
  String get path {
    switch (this) {
      case Routes.SPLASH:
        return "/splash";
      case Routes.FIRST_TIME:
        return "/frist-time";
      case Routes.LOGIN:
        return "/auth/login";
      case Routes.LOGIN_EMAIL:
        return "/auth/login-email";
      case Routes.REGISTER:
        return "/auth/register";
      case Routes.FORGOT_PASSWORD:
        return "/auth/forgot-password";
      case Routes.HOME:
        return "/home";
      case Routes.EMAIL_VERIFICATION:
        return "/auth/email-verification";
    }
  }
}
