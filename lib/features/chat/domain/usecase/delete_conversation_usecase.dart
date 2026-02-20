import '../../../../core/base_usecase/base_usecase.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/either.dart';
import '../../repo/chat_repo.dart';


class DeleteConversationParams {
  final String conversationId;

  const DeleteConversationParams(this.conversationId);
}

class DeleteConversationUseCase
    extends BaseUseCase<void, DeleteConversationParams> {
  final BotRepository repository;

  DeleteConversationUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(
      DeleteConversationParams params,
      ) {
    return repository.deleteConversation(params.conversationId);
  }
}