import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pos_merchant/core/theme/app_colors.dart';
import 'package:pos_merchant/presentation/bloc/auth/auth_bloc.dart';
import 'package:pos_merchant/presentation/bloc/auth/auth_event.dart';
import 'package:pos_merchant/presentation/bloc/auth/auth_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral,
      appBar: AppBar(
        backgroundColor: AppColors.neutral,
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () =>
                context.read<AuthBloc>().add(const AuthLogoutRequested()),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            context.go('/register');
          }
        },
        child: const Center(child: Text('Authenticated')),
      ),
    );
  }
}
