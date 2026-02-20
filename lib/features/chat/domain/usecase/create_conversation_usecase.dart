import '../../../../core/base_usecase/base_usecase.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/either.dart';
import '../../repo/chat_repo.dart';
import '../entity/conversation_entity.dart';


class CreateConversationUseCase
    extends BaseUseCase<ConversationEntity, ConversationEntity> {
  final BotRepository repository;

  CreateConversationUseCase(this.repository);

  @override
  Future<Either<Failure, ConversationEntity>> call(
      ConversationEntity params,
      ) {
    return repository.createConversation(params);
  }
}