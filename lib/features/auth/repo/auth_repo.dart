import '../../../../core/utils/either.dart';

import '../../../core/errors/failure.dart';
import '../domain/entities/auth_entity.dart';


abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> forgotPassword({
    required String email,
  });

  Future<Either<Failure, String>> verifyOtp({
    required String email,
    required String otp,
  });

  Future<Either<Failure, String>> resetPassword({
    required String email,
    required String newPassword,
  });
}