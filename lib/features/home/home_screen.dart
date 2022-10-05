import 'package:firebase_chat/core/components/components.dart';
import 'package:firebase_chat/core/cubit/cubit.dart';
import 'package:firebase_chat/core/cubit/state.dart';
import 'package:firebase_chat/features/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/network/local/SharedPreferences.dart';

class HomeLayOut extends StatefulWidget {
  const HomeLayOut({Key? key}) : super(key: key);

  @override
  State<HomeLayOut> createState() => _HomeLayOutState();
}

class _HomeLayOutState extends State<HomeLayOut> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: Text('ss'),
            backgroundColor: Colors.black,
            actions: [
              IconButton(
                  onPressed: () {
                    CacheHelper.removeData(key: 'uId');
                    navigateFinish(context, LoginScreen());
                  },
                  icon: const Icon(
                    Icons.ac_unit,
                    color: Colors.white70,
                  )),
              IconButton(
                  onPressed: () {
                    SocialCubit.get(context).onchangeappmode();
                  },
                  icon: const Icon(
                    Icons.language,
                    color: Colors.white70,
                  )),
            ],
            title: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white70,
                )),
          ),
          body: Center(
            child: Column(
              children: [
               Row(
                 children: [
                   Text('Plese Verfiy Your Email Address'),
                   Spacer(),
                   defaultButton(function: (){}, text: 'Send Email Verfication')
                 ],
               )
              ],
            ),
          ),
        );
      },
    );
  }
}
