import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:pos_merchant/core/di/injection.dart';
import 'package:pos_merchant/core/router/app_router.dart';
import 'package:pos_merchant/presentation/bloc/auth/auth_bloc.dart';
import 'package:pos_merchant/presentation/bloc/auth/auth_event.dart';

void main() {
  configureDependencies();
  if (kIsWeb) {
    setUrlStrategy(PathUrlStrategy());
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthBloc _authBloc = sl<AuthBloc>()
    ..add(const AuthCurrentUserRequested());
  late final _router = createAppRouter(_authBloc);

  @override
  void dispose() {
    _router.dispose();
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider.value(value: _authBloc)],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Manrope',
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.blue,
            selectionColor: Colors.blue.shade100,
            selectionHandleColor: Colors.blue,
          ),
        ),
        routerConfig: _router,
      ),
    );
  }
}
