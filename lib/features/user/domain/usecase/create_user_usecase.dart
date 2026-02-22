import 'package:untitled10/core/base_usecase/base_usecase.dart';
import 'package:untitled10/core/entity/auth_entity.dart';
import 'package:untitled10/core/errors/failure.dart';
import 'package:untitled10/core/utils/either.dart';
import 'package:untitled10/features/user/domain/create_user_parametres.dart';
import 'package:untitled10/features/user/repo/user_repo.dart';

class CreateUserUseCase
    extends BaseUseCase<UserEntity, CreateUserParams> {
  final UserRepository repository;

  CreateUserUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(
      CreateUserParams params) {
    return repository.createUser(params);
  }
}