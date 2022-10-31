import 'package:firebase_chat/core/components/components.dart';
import 'package:firebase_chat/core/network/local/SharedPreferences.dart';
import 'package:firebase_chat/features/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/cubit/cubit.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
            onPressed: () {
              SocialCubit.get(context).onchangeappmode();
            },
            child: Row(
              children: [
                Text('Change Theme'),
                Spacer(),
                Icon(Icons.dark_mode)
              ],
            )),
        Divider(
            thickness: 5,
            height: 5, color: Colors.black),
        TextButton(
            onPressed: () {
              SocialCubit.get(context).changeLanguage();},
            child: Row(
              children: [
                Text('Change Language'),
                Spacer(),
                Icon(Icons.language)
              ],
            )),
        Divider(
            thickness: 5,
            height: 5, color: Colors.black),
        TextButton(
            onPressed: () {
              CacheHelper.removeData(key: 'uId');
              navigateFinish(context, LoginScreen());},
            child: Row(
              children: [
                Text('Log Out'),
                Spacer(),
                Icon(Icons.logout)
              ],
            )),

      ],
    );
  }
}
