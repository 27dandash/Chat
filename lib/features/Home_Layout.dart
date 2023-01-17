import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/components/components.dart';
import 'package:firebase_chat/core/cubit/cubit.dart';
import 'package:firebase_chat/core/cubit/state.dart';
import 'package:firebase_chat/features/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'new_post/new_post.dart';
import '../core/components/constants.dart';

import '../core/network/local/SharedPreferences.dart';

class HomeLayOut extends StatefulWidget {
  const HomeLayOut({Key? key}) : super(key: key);

  @override
  State<HomeLayOut> createState() => _HomeLayOutState();
}

class _HomeLayOutState extends State<HomeLayOut> {
  bool isPassword = true;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialNewPostState){
          navigateTo(context, NewPostScreen());

        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Directionality(
          textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(

              title: Text(cubit.Titels[cubit.currentIndex]),
              // backgroundColor: Colors.black,
              actions: [
                 IconButton(onPressed: (){}, icon:  const Icon(Icons.search),),
                 IconButton(onPressed: (){}, icon:  const Icon(Icons.notification_add),)
              ],
            ),
            body: cubit.bottomScreen[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.Changebottomnav(index);
              },
              items:  const [
                BottomNavigationBarItem(label: 'newspaper',icon: Icon(Icons.newspaper)),
                BottomNavigationBarItem(label: 'chat',icon: Icon(Icons.chat)),
                BottomNavigationBarItem(label: 'Post',icon: Icon(Icons.post_add)),
                BottomNavigationBarItem(label: 'user',icon: Icon(Icons.verified_user_sharp)),
                BottomNavigationBarItem(label: 'settings',icon: Icon(Icons.settings)),
              ],
            ),
          ),
        );
      },
    );
  }
}
