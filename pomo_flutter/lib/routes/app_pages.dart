import 'package:PomoFlutter/content/auth/pages/email_verification_page.dart';
import 'package:PomoFlutter/content/auth/pages/forgot_password_page.dart';
import 'package:PomoFlutter/content/auth/pages/login_email_page.dart';
import 'package:PomoFlutter/content/auth/pages/login_external_providers_page.dart';
import 'package:PomoFlutter/content/auth/pages/register_page.dart';
import 'package:PomoFlutter/content/auth/storage/binding/email_verification_binding.dart';
import 'package:PomoFlutter/content/first_time/pages/first_time_page.dart';
import 'package:PomoFlutter/content/first_time/storage/binding/first_time_binding.dart';
import 'package:PomoFlutter/content/home/pages/main_page.dart';
import 'package:PomoFlutter/content/home/pages/task_list_page.dart';
import 'package:PomoFlutter/content/home/pages/timer_page.dart';
import 'package:PomoFlutter/content/home/storage/binding/calendary_binding.dart';
import 'package:PomoFlutter/content/home/storage/binding/home_binding.dart';
import 'package:PomoFlutter/content/home/storage/binding/main_binding.dart';
import 'package:PomoFlutter/content/home/storage/binding/profile_binding.dart';
import 'package:PomoFlutter/content/home/storage/binding/task_form_binding.dart';
import 'package:PomoFlutter/content/home/storage/binding/timer_binding.dart';
import 'package:PomoFlutter/content/splash/pages/splash_page.dart';
import 'package:PomoFlutter/content/splash/storage/binding/splash_binding.dart';
import 'package:PomoFlutter/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.SPLASH.path,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.FIRST_TIME.path,
      page: () => const FirstTimePage(),
      binding: FirstTimeBinding(),
    ),
    GetPage(
      name: Routes.LOGIN.path,
      page: () => const LoginExternalProvidersPage(),
    ),
    GetPage(
      name: Routes.LOGIN_EMAIL.path,
      page: () => const LoginEmailPage(),
    ),
    GetPage(
      name: Routes.REGISTER.path,
      page: () => const RegisterPage(),
    ),
    GetPage(
      name: Routes.FORGOT_PASSWORD.path,
      page: () => const ForgotPasswordPage(),
    ),
    GetPage(
      name: Routes.EMAIL_VERIFICATION.path,
      page: () => const EmailVerificationPage(),
      binding: EmailVerificationBinding(),
    ),
    GetPage(
      name: Routes.MAIN.path,
      page: () => const MainPage(),
      binding: MainBinding(),
      bindings: [
        HomeBinding(),
        TaskFormBinding(),
        ProfileBinding(),
        CalendaryBinding(),
        TimerBinding(),
      ],
    ),
    GetPage(
      name: Routes.LIST_TASKS.path,
      page: () => const TaskListPage(),
    ),
    GetPage(
      name: Routes.TIMER_PAGES.path,
      page: () => const TimerPage(),
    ),
  ];
}
