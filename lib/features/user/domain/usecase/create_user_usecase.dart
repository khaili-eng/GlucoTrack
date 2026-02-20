import '../../../../core/base_usecase/base_usecase.dart';
import '../../../../core/entity/auth_entity.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/either.dart';
import '../../repo/user_repo.dart';


class CreateUserUseCase extends BaseUseCase<UserEntity, UserEntity> {
  final UserRepository repository;

  CreateUserUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(UserEntity params) {
    return repository.createUser(params);
  }
}