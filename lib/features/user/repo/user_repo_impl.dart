import 'package:untitled10/features/user/repo/user_repo.dart';
import '../../../../core/utils/either.dart';
import '../../../core/entity/auth_entity.dart';
import '../../../core/errors/failure.dart';
import '../../../core/network/api_service.dart';
import '../data/models/user_model.dart';


class UserRepositoryImpl implements UserRepository {
  final ApiService apiService;

  UserRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, UserEntity>> createUser(UserEntity user) async {
    try {
      final response = await apiService.createUser(
        UserModel(id: user.id, name: user.name, email: user.email).toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(UserModel.fromJson(response.data));
      }

      return const Left(ServerFailure(message: 'Server Error'));
    } catch (_) {
      return const Left(NetworkFailure(message: 'Network Error'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUser(int id) async {
    try {
      final response = await apiService.getUser(id);

      if (response.statusCode == 200) {
        return Right(UserModel.fromJson(response.data));
      }

      return const Left(ServerFailure(message: 'Server Error'));
    } catch (_) {
      return const Left(NetworkFailure(message: 'Network Error'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateUser(UserEntity user) async {
    try {
      final response = await apiService.updateUser(
        user.id,
        UserModel(id: user.id, name: user.name, email: user.email).toJson(),
      );

      if (response.statusCode == 200) {
        return Right(UserModel.fromJson(response.data));
      }

      return const Left(ServerFailure(message: 'Server Error'));
    } catch (_) {
      return const Left(NetworkFailure(message: 'Network Error'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteUser(int id) async {
    try {
      final response = await apiService.deleteUser(id);

      if (response.statusCode == 200 || response.statusCode == 204) {
        return const Right(true);
      }

      return const Left(ServerFailure(message: 'Server Error'));
    } catch (_) {
      return const Left(NetworkFailure(message: 'Network Error'));
    }
  }
}