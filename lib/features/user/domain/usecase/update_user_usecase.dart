import '../../../../core/base_usecase/base_usecase.dart';
import '../../../../core/entity/auth_entity.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/either.dart';
import '../../repo/user_repo.dart';


class UpdateUserUseCase extends BaseUseCase<UserEntity, UserEntity> {
  final UserRepository repository;

  UpdateUserUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(UserEntity params) {
    return repository.updateUser(params);
  }
}