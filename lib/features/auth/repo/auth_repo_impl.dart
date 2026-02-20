
import '../../../../core/utils/either.dart';
import '../../../core/errors/failure.dart';
import '../../../core/network/api_service.dart';

import '../data/models/auth_model.dart';
import '../domain/entities/auth_entity.dart';

import 'auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiService apiService;

  AuthRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, AuthEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiService.login(email: email, password: password);

      if (response.statusCode == 200) {
        return Right(AuthModel.fromJson(response.data));
      } else if (response.statusCode == 401) {
        return const Left(UnauthorizedFailure(message: 'Unauthorized'));
      } else if (response.statusCode == 422) {
        return const Left(ValidationFailure(message: 'Validation Error'));
      } else {
        return const Left(ServerFailure(message: 'Server Error'));
      }
    } catch (e) {
      return const Left(NetworkFailure(message: 'Network Error'));
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword({
    required String email,
  }) async {
    try {
      await apiService.forgotPassword(email);
      return const Right('OTP Sent');
    } catch (_) {
      return const Left(NetworkFailure(message: 'Network Error'));
    }
  }

  @override
  Future<Either<Failure, String>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      await apiService.verifyOtp(email, otp);
      return const Right('OTP Verified');
    } catch (_) {
      return const Left(NetworkFailure(message: 'Network Error'));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      await apiService.resetPassword(email, newPassword);
      return const Right('Password Reset');
    } catch (_) {
      return const Left(NetworkFailure(message: 'Network Error'));
    }
  }
}