import '../../../../core/base_usecase/base_usecase.dart';
import '../../../../core/entity/auth_entity.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/either.dart';
import '../../repo/user_repo.dart';


class GetUserUseCase extends BaseUseCase<UserEntity, int> {
  final UserRepository repository;

  GetUserUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(int params) {
    return repository.getUser(params);
  }
}