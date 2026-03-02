import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_merchant/domain/repositories/auth_repository.dart';
import 'package:pos_merchant/domain/usecases/login_usecase.dart';
import 'package:pos_merchant/domain/usecases/register_usecase.dart';
import 'package:pos_merchant/presentation/bloc/auth/auth_event.dart';
import 'package:pos_merchant/presentation/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final AuthRepository authRepository;

  AuthBloc({
    required this.loginUsecase,
    required this.registerUsecase,
    required this.authRepository,
  }) : super(const AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthCurrentUserRequested>(_onCurrentUserRequested);
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading(user: state.user));
    try {
      final user = await loginUsecase.call(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated(user));
    } catch (error) {
      emit(AuthFailure(_mapErrorMessage(error), user: state.user));
    }
  }

  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading(user: state.user));
    try {
      final user = await registerUsecase.call(
        name: event.name,
        businessName: event.businessName,
        mobileNumber: event.mobileNumber,
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated(user));
    } catch (error) {
      emit(AuthFailure(_mapErrorMessage(error), user: state.user));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading(user: state.user));
    try {
      await authRepository.logout();
      emit(const AuthUnauthenticated());
    } catch (error) {
      emit(AuthFailure(_mapErrorMessage(error), user: state.user));
    }
  }

  Future<void> _onCurrentUserRequested(
    AuthCurrentUserRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthChecking());
    try {
      final user = await authRepository.getCurrentUser();
      if (user == null) {
        emit(const AuthUnauthenticated());
        return;
      }
      emit(AuthAuthenticated(user));
    } catch (error) {
      emit(AuthFailure(_mapErrorMessage(error), user: state.user));
    }
  }

  String _mapErrorMessage(Object error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionError) {
        final origin = error.requestOptions.uri.origin;
        return 'Cannot connect to server at $origin. Check backend is running and API_BASE_URL is correct.';
      }
      final data = error.response?.data;
      if (data is Map<String, dynamic>) {
        final message = data['message'];

        if (message is String && message.trim().isNotEmpty) {
          return message;
        }
      }
      return error.message ?? 'Network request failed';
    }
    return error.toString();
  }
}
