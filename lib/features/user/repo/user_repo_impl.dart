import 'package:untitled10/features/user/domain/create_user_parametres.dart';
import 'package:untitled10/features/user/repo/user_repo.dart';
import '../../../../core/utils/either.dart';
import '../../../core/entity/auth_entity.dart';
import '../../../core/errors/failure.dart';
import '../data/datasource/user_remote_datasource.dart';



class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
 Future<Either<Failure, UserEntity>> createUser(
    CreateUserParams params) async {
  try {
    final response = await remoteDataSource.createUser(params);

    if (response.success && response.data != null) {
      return Right(response.data!);
    }

    return Left(ServerFailure(message: response.message ?? 'Server Error'));
  } catch (_) {
    return const Left(NetworkFailure(message: 'Network Error'));
  }
}
  @override
  Future<Either<Failure, UserEntity>> getUser(int id) async {
    try {
      final response = await remoteDataSource.getUser(id);

      if (response.success && response.data != null) {
        return Right(response.data!);
      }

      return Left(ServerFailure(message: response.message ?? 'Server Error'));
    } catch (_) {
      return const Left(NetworkFailure(message: 'Network Error'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateUser(UserEntity user) async {
    try {
      final response = await remoteDataSource.updateUser(user);

      if (response.success && response.data != null) {
        return Right(response.data!);
      }

      return Left(ServerFailure(message: response.message ?? 'Server Error'));
    } catch (_) {
      return const Left(NetworkFailure(message: 'Network Error'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteUser(int id) async {
    try {
      final response = await remoteDataSource.deleteUser(id);

      if (response.success) {
        return const Right(true);
      }

      return Left(ServerFailure(message: response.message ?? 'Server Error'));
    } catch (_) {
      return const Left(NetworkFailure(message: 'Network Error'));
    }
  }
}