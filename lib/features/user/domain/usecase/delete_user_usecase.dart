import '../../../../core/base_usecase/base_usecase.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/either.dart';
import '../../repo/user_repo.dart';


class DeleteUserUseCase extends BaseUseCase<bool, int> {
  final UserRepository repository;

  DeleteUserUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(int params) {
    return repository.deleteUser(params);
  }
}