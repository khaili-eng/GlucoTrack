import '../../../../core/base_usecase/base_usecase.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/either.dart';
import '../../repo/auth_repo.dart';


class ForgotPasswordUseCase extends BaseUseCase<String, String> {
  final AuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(String email) {
    return repository.forgotPassword(email: email);
  }
}