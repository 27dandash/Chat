import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/components/constants.dart';
import 'core/cubit/cubit.dart';
import 'core/cubit/state.dart';
import 'core/network/bloc_observer.dart';
import 'core/network/local/SharedPreferences.dart';
import 'core/network/remote/dio_helper.dart';
import 'core/themes.dart';
import 'features/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences.getInstance();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding') == null ? false  : CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token') == null ? null : CacheHelper.getData(key: 'token');
  isRtl = CacheHelper.getData(key: 'isRtl') == null ? false : CacheHelper.getData(key: 'isRtl');
  String translation = await rootBundle
      .loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');

  runApp(MyApp(
    translation: translation, isRtl : isRtl,
  ));
}

class MyApp extends StatelessWidget {
  final String translation;
  final bool isRtl;
  MyApp({required this.translation, required this.isRtl});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>SocialCubit()
        ..checkConnectivity()
        ..setTranslation(translation: translation),

      child: BlocConsumer<SocialCubit , SocialStates> (
        listener:  (context, state) {},
        builder:  (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: LoginScreen(),
          );
        },
      ),
    );
  }
}

