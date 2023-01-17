import 'package:firebase_chat/features/Home_Layout.dart';
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
import 'core/theme/app_theme.dart';
import 'core/theme/themes.dart';
import 'features/login/cubit/cubit.dart';
import 'features/login/login_screen.dart';
import 'features/register/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences.getInstance();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  DioHelper.init();
  await CacheHelper.init();
  bool? isdark = CacheHelper.getData(key: 'Isdark');
  Widget widget;
  // bool onBoarding = CacheHelper.getData(key: 'onBoarding') == null ? false  : CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'uId');
  isRtl = CacheHelper.getData(key: 'isRtl') ?? false;
  String translation = await rootBundle
      .loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');

  if (token != null) {
    widget = const HomeLayOut();
    print(token);
  } else {
    widget = LoginScreen();
  }

  runApp(MyApp(
    startWidget: widget,
    isRtl: isRtl,
    translation: translation,
    isdark: isdark,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isdark;

  final Widget startWidget;
  final bool isRtl;
  final String translation;

  MyApp(
      {required this.startWidget,
      required this.isRtl,
      required this.isdark,
      required this.translation});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SocialCubit>(
            create: (BuildContext context) => SocialCubit()
              ..setTranslation(translation: translation)
              ..checkConnectivity()
              ..getUserData()
              ..getPosts()
               // ..getMessages
              ..onchangeappmode(
                formShared: isdark,
              )),
        BlocProvider<SocialLoginCubit>(
            create: (BuildContext context) => SocialLoginCubit()),
        BlocProvider<SocialRegisterCubit>(
            create: (BuildContext context) => SocialRegisterCubit())
      ],
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme().lightTheme,
            darkTheme: AppTheme().darkTheme,
            themeMode: cubit.AppTheme ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
