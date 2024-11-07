import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/core/constants/styles.dart';
import 'package:chat_app/core/extension/widget_extension.dart';
import 'package:chat_app/core/models/user_model.dart';
import 'package:chat_app/core/services/chat_service.dart';
import 'package:chat_app/ui/screens/bottom_navigation/chats_list/chat_room/chat_viewmodel.dart';
import 'package:chat_app/ui/screens/bottom_navigation/chats_list/chat_room/chat_widget.dart';
import 'package:chat_app/ui/screens/other/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.receiver});

  final UserModel receiver;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).user;
    return ChangeNotifierProvider(
      create: (context) =>
          ChatViewmodel(ChatService(), currentUser!, widget.receiver),
      child: Consumer<ChatViewmodel>(builder: (context, model, _) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 1.sw * 0.05,
                    vertical: 10.h,
                  ),
                  child: Column(
                    children: [
                      35.verticalSpace,
                      _buildHeader(context, name: widget.receiver.name!),
                      10.verticalSpace,
                      Expanded(
                        child: ListView.separated(
                          reverse: false,
                          padding: const EdgeInsets.all(0),
                          separatorBuilder: (context, index) =>
                              10.verticalSpace,
                          itemCount: model.messages.length,
                          itemBuilder: (context, index) {
                            final message = model.messages[index];
                            return ChatBubble(
                              isCurrentUser:
                                  message.senderId == currentUser!.uid,
                              message: message,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BottomField(
                controller: model.controller,
                onTap: () async {
                  try {
                    await model.saveMessage();
                  } catch (e) {
                    context.showSnackbar(e.toString());
                  }
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  Row _buildHeader(BuildContext context, {String name = ""}) {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: EdgeInsets.only(left: 10, top: 6, bottom: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: grey.withOpacity(0.15),
            ),
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
        15.horizontalSpace,
        Text(
          name,
          style: h.copyWith(fontSize: 20.sp),
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: grey.withOpacity(0.15),
          ),
          child: const Icon(Icons.more_vert),
        ),
      ],
    );
  }
}

// class ChatBubble extends StatelessWidget {
//   const ChatBubble({
//     super.key,
//     this.isCurrentUser = true,
//     required this.message,
//   });

//   final bool isCurrentUser;
//   final Message message;

//   @override
//   Widget build(BuildContext context) {
//     final borderRadius = isCurrentUser
//         ? BorderRadius.only(
//             topLeft: Radius.circular(16.r),
//             topRight: Radius.circular(16.r),
//             bottomLeft: Radius.circular(16.r),
//           )
//         : BorderRadius.only(
//             topLeft: Radius.circular(16.r),
//             topRight: Radius.circular(16.r),
//             bottomRight: Radius.circular(16.r),
//           );
//     final alignment =
//         isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
//     return Align(
//       alignment: alignment,
//       child: Container(
//         constraints: BoxConstraints(maxWidth: 1.sw * 0.8, minWidth: 50.w),
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: isCurrentUser ? primary : grey.withOpacity(0.2),
//           borderRadius: borderRadius,
//         ),
//         child: Column(
//           crossAxisAlignment:
//               isCurrentUser ? CrossAxisAlignment.start : CrossAxisAlignment.end,
//           children: [
//             Text(
//               message.content!,
//               style: body.copyWith(color: isCurrentUser ? white : null),
//             ),
//             5.verticalSpace,
//             Text(
//               message.timestamp.toString(),
//               style: small.copyWith(color: isCurrentUser ? white : null),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
