import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
              appBar: AppBar(
                leading: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                      onTap: () {
                        SocialCubit.get(context).changeLanguage();
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://images.wallpaperscraft.com/image/single/building_showcase_art_140944_1280x720.jpg'),
                        radius: 3,
                      )),
                ),
                title: Text('News Feed'),
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
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).model !=null,
                builder: (BuildContext context) {
                  var model=SocialCubit.get(context).model ;
                  return Column(
                    children: [
                      if(FirebaseAuth.instance.currentUser!.emailVerified==null)
                      Container(
                        color: Colors.amber.withOpacity(0.6),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Icon(Icons.warning_amber),
                              // SizedBox(width: 5,),
                              Expanded(child: Text('Plese Verfiy Your Email Address',style: TextStyle(fontSize: 14),)),
                              defaultButton(
                                  ccolor: Colors.blue,
                                  background: Colors.transparent,
                                  width:100,
                                  function: (){
                                    FirebaseAuth.instance.currentUser!.
                                    sendEmailVerification().then((value){
                                      showToast(message: 'check your mail', toastStates: ToastStates.SUCCESS);
                                    }).
                                    catchError((onError){
                                      print('=====================error============$onError');
                                    });
                                  }, text: 'Send')
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
                fallback: (BuildContext context) {
                  return const Center(child: CircularProgressIndicator( color: Colors.blue,));
                },
              )),
        );
      },
    );
  }
}
