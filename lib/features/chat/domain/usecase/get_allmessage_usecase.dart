import '../../../../core/base_usecase/base_usecase.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/pagination_params.dart';
import '../../repo/chat_repo.dart';
import '../entity/message_entity.dart';


class GetAllMessageParams {
  final String conversationId;
  final PaginationParams pagination;

  const GetAllMessageParams({
    required this.conversationId,
    required this.pagination,
  });
}

class GetAllMessageUseCase
    extends BaseUseCase<List<MessageEntity>, GetAllMessageParams> {
  final BotRepository repository;

  GetAllMessageUseCase(this.repository);

  @override
  Future<Either<Failure, List<MessageEntity>>> call(
      GetAllMessageParams params,
      ) {
    return repository.getAllMessages(
      conversationId: params.conversationId,
      pagination: params.pagination,
    );
  }
}