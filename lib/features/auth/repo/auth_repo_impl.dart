
import '../../../../core/utils/either.dart';
import '../../../core/errors/failure.dart';

import '../data/datasource/auth_remote_datasource.dart';
import '../domain/entities/auth_entity.dart';

import 'auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, AuthEntity>> login({
    required String email,
    required String password,
  }) async {
    final result = await remoteDataSource.login(email: email, password: password);
    if (result.success && result.data != null) {
      return Right(result.data!);
    } else {
      return Left(_mapFailure(result));
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword({
    required String email,
  }) async {
    final result = await remoteDataSource.forgotPassword(email: email);
    if (result.success) {
      return const Right('OTP Sent');
    } else {
      return Left(_mapFailure(result));
    }
  }

  @override
  Future<Either<Failure, String>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final result = await remoteDataSource.verifyOtp(email: email, otp: otp);
    if (result.success) {
      return const Right('OTP Verified');
    } else {
      return Left(_mapFailure(result));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    final result = await remoteDataSource.resetPassword(email: email, newPassword: newPassword);
    if (result.success) {
      return const Right('Password Reset');
    } else {
      return Left(_mapFailure(result));
    }
  }

  Failure _mapFailure(dynamic result) {
    final code = result.statusCode;
    final message = result.message ?? 'Unknown error';
    if (code == 401) {
      return UnauthorizedFailure(message: message, code: code);
    } else if (code == 422) {
      return ValidationFailure(message: message, code: code);
    } else if (code == 500) {
      return ServerFailure(message: message, code: code);
    } else if (code == null) {
      return NetworkFailure(message: message);
    } else {
      return UnknownFailure(message: message);
    }
  }
}