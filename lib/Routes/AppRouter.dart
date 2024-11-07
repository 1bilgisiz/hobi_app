import 'package:go_router/go_router.dart';
import 'package:hobiapp/App/Auth/Login/View/LoginView.dart';
import 'package:hobiapp/App/Auth/Signup/View/SignupView.dart';
import 'package:hobiapp/App/Home/View/HomeView.dart';
import 'package:hobiapp/App/Splash/View/SplashView.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        name: RoutesNames.splashView,
        path: "/",
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        name: RoutesNames.loginView,
        path: "/loginView",
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        name: RoutesNames.signupView,
        path: "/signupView",
        builder: (context, state) => const SignupView(),
      ),
      GoRoute(
        name: RoutesNames.homeView,
        path: "/homeView",
        builder: (context, state) => const HomeView(),
      ),
    ],
  );

  //Singleton Factory
  static final AppRouter _instance = AppRouter._init();

  factory AppRouter() {
    return _instance;
  }

  AppRouter._init();
}

class RoutesNames {
  static const splashView = "splashView";
  static const homeView = "homeView";
  static const loginView = "loginView";
  static const signupView = "signupView";
}
