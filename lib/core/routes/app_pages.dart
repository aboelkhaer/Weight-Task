import 'package:get/get.dart';
import '../../view/views.dart';
import '../bindings/bindings.dart';

class AppRoutes {
  static const String _home = '/';
  static String goToHomeRoute() => _home;

  static const String _login = '/login';
  static String goToLoginRoute() => _login;

  static List<GetPage> routes = [
    GetPage(
      name: _home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
  ];
}
