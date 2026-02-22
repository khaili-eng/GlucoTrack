
import 'package:untitled10/features/user/domain/create_user_parametres.dart';

import '../../../../core/utils/either.dart';
import '../../../core/entity/auth_entity.dart';
import '../../../core/errors/failure.dart';


abstract class UserRepository {
 Future<Either<Failure, UserEntity>> createUser(
    CreateUserParams params);
  Future<Either<Failure, UserEntity>> getUser(int id);
  Future<Either<Failure, UserEntity>> updateUser(UserEntity user);
  Future<Either<Failure, bool>> deleteUser(int id);
}