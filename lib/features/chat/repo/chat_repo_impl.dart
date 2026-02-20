
import '../../../../core/utils/either.dart';
import '../../../core/errors/failure.dart';
import '../../../core/network/api_service.dart';

import '../data/conversation_model.dart';
import '../data/message_model.dart';
import '../domain/entity/conversation_entity.dart';
import '../domain/entity/message_entity.dart';
import 'chat_repo.dart';

class BotRepositoryImpl implements BotRepository {
  final ApiService apiService;

  BotRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, ConversationEntity>> createConversation(int userId) async {
    try {
      final response = await apiService.createConversation(userId);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(ConversationModel.fromJson(response.data));
      }
      return const Left(ServerFailure(message: 'Server Error'));
    } catch (_) {
      return const Left(NetworkFailure(message: 'Network Error'));
    }
  }

  @override
  Future<Either<Failure, ConversationEntity>> getConversation(int id) async {
    try {
      final response = await apiService.getConversation(id);
      if (response.statusCode == 200) {
        return Right(ConversationModel.fromJson(response.data));
      }
      return const Left(ServerFailure(message: 'Server Error'));
    } catch (_) {
      return const Left(NetworkFailure(message: 'Network Error'));
    }
  }

  @override
  Future<Either<Failure, List<ConversationEntity>>> getAllConversations(int userId) async {
    try {
      final response = await apiService.getAllConversations(userId);
      if (response.statusCode == 200) {
        final list = (response.data as List)
            .map((e) => ConversationModel.fromJson(e))
            .toList();
        return Right(list);
      }
      return const Left(ServerFailure(message: 'Server Error'));
    } catch (_) {
      return const Left(NetworkFailure(message: 'Network Error'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteConversation(int id) async {
    try {
      final response = await apiService.deleteConversation(id);
      if (response.statusCode == 200 || response.statusCode == 204) {
        return const Right(true);
      }
      return const Left(ServerFailure(message: 'Server Error'));
    } catch (_) {
      return const Left(NetworkFailure(message: 'Network Error'));
    }
  }

  @override
  Future<Either<Failure, MessageEntity>> sendMessage(MessageEntity message) async {
    try {
      final response = await apiService.createMessage(
        MessageModel(
          id: message.id,
          conversationId: message.conversationId,
          content: message.content,
          role: message.role,
        ).toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(MessageModel.fromJson(response.data));
      }
      return const Left(ServerFailure(message: 'Server Error'));
    } catch (_) {
      return const Left(NetworkFailure(message: 'Network Error'));
    }
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> getAllMessages(int conversationId) async {
    try {
      final response = await apiService.getMessages(conversationId);
      if (response.statusCode == 200) {
        final list = (response.data as List)
            .map((e) => MessageModel.fromJson(e))
            .toList();
        return Right(list);
      }
      return const Left(ServerFailure(message: 'Server Error'));
    } catch (_) {
      return const Left(NetworkFailure(message: 'Network Error'));
    }
  }
}