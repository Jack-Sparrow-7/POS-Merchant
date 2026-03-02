import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:pos_merchant/presentation/bloc/auth/auth_bloc.dart';
import 'package:pos_merchant/presentation/bloc/auth/auth_state.dart';
import 'package:pos_merchant/presentation/screens/auth_loading_screen.dart';
import 'package:pos_merchant/presentation/screens/forgot_password_screen.dart';
import 'package:pos_merchant/presentation/screens/home_screen.dart';
import 'package:pos_merchant/presentation/screens/register_screen.dart';
import 'package:pos_merchant/presentation/screens/sign_in_screen.dart';

GoRouter createAppRouter(AuthBloc authBloc) {
  return GoRouter(
    initialLocation: '/',
    refreshListenable: AuthRefreshListenable(authBloc.stream),
    redirect: (context, state) {
      final authState = authBloc.state;
      final authRoutes = ['/register', '/login', '/forgotPassword'];
      final isAuthRoute = authRoutes.contains(state.matchedLocation);
      final isOnLoadingRoute = state.matchedLocation == '/';

      // Show loading screen only for initial check (AuthInitial or AuthChecking)
      final isInitialCheck =
          authState is AuthInitial || authState is AuthChecking;
      final isAuthenticated = authState is AuthAuthenticated;

      if (isInitialCheck) return '/';
      if (isAuthenticated && (isAuthRoute || isOnLoadingRoute)) {
        return '/home';
      }
      if (!isAuthenticated && !isAuthRoute) return '/register';
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const AuthLoadingScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/forgotPassword',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    ],
  );
}

class AuthRefreshListenable extends ChangeNotifier {
  final Stream<dynamic> _stream;
  StreamSubscription<dynamic>? _subscription;

  AuthRefreshListenable(this._stream) {
    _subscription = _stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
