import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/forgot_password_usecase.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../domain/usecase/reset_password_usecase.dart';
import '../../domain/usecase/verify_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.forgotPasswordUseCase,
    required this.verifyOtpUseCase,
    required this.resetPasswordUseCase,
  }) : super(const AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(const AuthLoading());
    final result = await loginUseCase(LoginParams(email: email, password: password));
    result.fold(
      (failure) => emit(AuthError(failure)),
      (authEntity) => emit(AuthSuccess(authEntity)),
    );
  }

  Future<void> forgotPassword(String email) async {
    emit(const AuthLoading());
    final result = await forgotPasswordUseCase(email);
    result.fold(
      (failure) => emit(AuthError(failure)),
      (message) => emit(AuthSuccess(message)),
    );
  }

  Future<void> verifyOtp(String email, String otp) async {
    emit(const AuthLoading());
    final result = await verifyOtpUseCase(VerifyOtpParams(email: email, otp: otp));
    result.fold(
      (failure) => emit(AuthError(failure)),
      (message) => emit(AuthSuccess(message)),
    );
  }

  Future<void> resetPassword(String email, String password) async {
    emit(const AuthLoading());
    final result = await resetPasswordUseCase(ResetPasswordParams(email: email, newPassword: password));
    result.fold(
      (failure) => emit(AuthError(failure)),
      (message) => emit(AuthSuccess(message)),
    );
  }
}