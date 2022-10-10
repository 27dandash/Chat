import 'package:firebase_chat/core/components/components.dart';
import 'package:firebase_chat/core/cubit/cubit.dart';
import 'package:firebase_chat/core/cubit/state.dart';
import 'package:firebase_chat/features/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/components/constants.dart';
import '../../core/network/local/SharedPreferences.dart';

class HomeLayOut extends StatefulWidget {
  const HomeLayOut({Key? key}) : super(key: key);

  @override
  State<HomeLayOut> createState() => _HomeLayOutState();
}

class _HomeLayOutState extends State<HomeLayOut> {
  bool isPassword = true;

  var valdiateController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(

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

          ),
          body: Center(
            child: Column(
              children: [
               Text('Plese Verfiy Your Email Address'),
               Spacer(),
               Text('Plese Verfiy Your Email Address'),

                defaultFormField(
                  controller: valdiateController,
                  // onSubmit: (value){ if (formKey.currentState!.validate()) {
                  //   SocialLoginCubit.get(context).userlogin(
                  //       email:  emailController.text,
                  //       password: passwordController.text);
                  // }},
                  label: appTranslation(context).pass,
                  prefix: Icons.lock,

                  suffix:SocialCubit.get(context).suffix,

                  isPassword: isPassword,
                  suffixPressed: () {
                    setState(() {
                      isPassword = !isPassword;
                    });
                  },
                  type: TextInputType.visiblePassword,
                  validate: (String ?value) {
                    if (value!.isEmpty) {
                      return 'You have enter Password';
                    }

                    return null;
                    //'You Password is wrong';
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
