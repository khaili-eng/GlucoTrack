
import '../../../../core/utils/either.dart';
import '../../../core/entity/auth_entity.dart';
import '../../../core/errors/failure.dart';


abstract class UserRepository {
  Future<Either<Failure, UserEntity>> createUser(UserEntity user);
  Future<Either<Failure, UserEntity>> getUser(int id);
  Future<Either<Failure, UserEntity>> updateUser(UserEntity user);
  Future<Either<Failure, bool>> deleteUser(int id);
}