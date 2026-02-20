import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final int id;
  final int conversationId;
  final String content;
  final String role;

  const MessageEntity({
    required this.id,
    required this.conversationId,
    required this.content,
    required this.role,
  });

  @override
  List<Object?> get props => [id, conversationId, content, role];
}