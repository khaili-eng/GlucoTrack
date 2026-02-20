import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled10/core/color/app_color.dart';
import 'package:untitled10/core/localization/locale_cubit.dart';
import 'package:untitled10/features/chat/presentation/widgets/chat_empty_state.dart';

import '../manager/chat_cubit.dart';
import '../manager/chat_state.dart';
import '../widgets/bubble_typing_indicator.dart';
import '../widgets/chat_drawer.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_input.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit(),
      child: Scaffold(
        backgroundColor: AppColor.backgroundNeutral,
        resizeToAvoidBottomInset: true,
        drawer: const ChatDrawer(),
        appBar: AppBar(
          backgroundColor: AppColor.backgroundNeutral,
          elevation: 0,
          titleSpacing: 0,
          title: BlocBuilder<ChatCubit, ChatState>(
            buildWhen: (previous, current) =>
            previous.isBotTyping != current.isBotTyping,
            builder: (context, state) {
              return Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColor.info.withOpacity(0.1),
                        child: const Icon(
                            Icons.medical_services_outlined,
                            size: 18,
                            color: AppColor.info),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 10.w,
                          height: 10.h,
                          decoration: const BoxDecoration(
                            color: AppColor.positive,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        context.read<LocaleCubit>().translate('tit'),
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        state.isBotTyping ? "يكتب الآن..." : "متصل",
                        style: TextStyle(
                          fontSize: 12,
                          color: state.isBotTyping
                              ? Colors.orange
                              : AppColor.positive,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
        body: SafeArea(
          child: BlocListener<ChatCubit, ChatState>(
            listenWhen: (previous, current) =>
            previous.messages.length !=
                current.messages.length,
            listener: (context, state) {
              _scrollToBottom();
            },
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<ChatCubit, ChatState>(
                    builder: (context, state) {

                      if (state.messages.isEmpty) {
                        return const ChatEmptyState();
                      }

                      return ListView.builder(
                        controller: _scrollController,
                        padding:
                        const EdgeInsets.all(16),
                        reverse: true,
                        itemCount:
                        state.messages.length +
                            (state.isBotTyping ? 1 : 0),
                        itemBuilder: (context, index) {

                          if (state.isBotTyping &&
                              index == 0) {
                            return  BotTypingBubble ();
                          }

                          final message =
                          state.messages[
                          state.messages.length -
                              1 -
                              index];

                          return MessageBubble(
                            message: message,
                            isUser: message.isMe,
                          );
                        },
                      );
                    },
                  ),
                ),
                BlocBuilder<ChatCubit, ChatState>(
                  buildWhen: (previous, current) =>
                  previous.isBotTyping !=
                      current.isBotTyping,
                  builder: (context, state) {
                    return MessageInput(
                      enabled: !state.isBotTyping,
                      onSend: (text) {
                        context
                            .read<ChatCubit>()
                            .sendMessage(text);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}