import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_chat/core/components/components.dart';
import 'package:firebase_chat/core/cubit/cubit.dart';
import 'package:firebase_chat/core/cubit/cubit.dart';
import 'package:firebase_chat/core/cubit/state.dart';
import 'package:firebase_chat/core/models/user_model.dart';
import 'package:firebase_chat/features/schats/chat%20details%20screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return ConditionalBuilder(
          condition:cubit.users.isNotEmpty,
          builder: (context) {
            return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildChatItem(context,cubit.users[index]);
                },
                separatorBuilder: (context, index) {
                  return const Divider(thickness: 2, height: 5, color: Colors.grey);
                },
                itemCount: cubit.users.length,);
          },
          fallback: (context) {
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }

  Widget buildChatItem(context,UserModel model) {
    return InkWell(
      onTap: () {
        navigateTo(context, ChatDetailsScreen(
          usermodel: model,
        ));
      },
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children:  [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                '${model.img}',
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              '${model.name}',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
