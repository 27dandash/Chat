import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_chat/core/cubit/cubit.dart';
import 'package:firebase_chat/core/cubit/cubit.dart';
import 'package:firebase_chat/core/cubit/state.dart';
import 'package:firebase_chat/core/models/message_model.dart';
import 'package:firebase_chat/core/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreen extends StatelessWidget {
  ChatDetailsScreen({Key? key, required this.usermodel}) : super(key: key);

  UserModel usermodel;

  var MessageControler = TextEditingController();

  // ChatDetailsScreen(this.usermodel);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(recivreId: '${usermodel!.uId}');
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage('${usermodel.img}'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text('${usermodel.name}'),
                ],
              ),
            ),
            body: ConditionalBuilder(
              condition: SocialCubit.get(context).messages.isNotEmpty,
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              var message =
                                  SocialCubit.get(context).messages[index];
                              SocialCubit.get(context).userModel!.uId ==
                                  message.senderId;
                              // معناها اي ؟؟؟؟ }
                              return buildReciverMessage(message);
                              return buildMessage(message);
                              //{
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 15,
                              );
                            },
                            itemCount: SocialCubit.get(context).messages.length),
                      ),
                      Spacer(),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: MessageControler,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Leave Your Message Here'),
                              ),
                            ),
                            Container(
                                height: 40,
                                color: Colors.deepOrange,
                                child: MaterialButton(
                                  onPressed: () {
                                    SocialCubit.get(context).sendMessage(
                                        recivreId: '${usermodel.uId}',
                                        dateTime: DateTime.now().toString(),
                                        text: MessageControler.text);
                                  },
                                  // onHighlightChanged:,
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              fallback: (context) {
                return Container(
                  child: Center(
                    child: Text('No Message Now , Start Messaging ...'),
                  ),
                );
              },
            ),
          );
        },
      );
    });
  }

  Widget buildMessage(MessageModel model) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            )),
        child:  Column(
          children: [
            Text('${model.text}'),
            Text('${model.dateTime}')
          ],
        ),
      ),
    );
  }

  Widget buildReciverMessage(MessageModel model) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.green[300],
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            )),
        child:  Text('${model.text}'),
      ),
    );
  }
}
