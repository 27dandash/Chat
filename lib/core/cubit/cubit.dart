import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_chat/core/components/constants.dart';
import 'package:firebase_chat/core/cubit/state.dart';
import 'package:firebase_chat/core/network/local/SharedPreferences.dart';
import 'package:firebase_chat/core/usermodel/model.dart';
import 'package:firebase_chat/features/feeds/feeds%20screen.dart';
import 'package:firebase_chat/features/schats/chats%20screen.dart';
import 'package:firebase_chat/features/setting/setting%20screen.dart';
import 'package:firebase_chat/features/users/users%20screen.dart';
import 'package:firebase_chat/translation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? model;

  void getUserData() {
    emit(SocialLoadGetUserSuccessState());
    FirebaseFirestore.instance
        .collection('user')
        .doc(token)
        .get()
        .then((value) {
      print('============data=============${value.data()!}');
      model = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

// ----------------------------------------- bottom navigation

  int currentIndex = 0;

  List<Widget> bottomScreen = [
    const FeedsScreen(),
    const ChatsScreen(),
    const UsersScreen(),
    const SettingScreen(),
  ];

  List<String> titels = [
    'Home',
    'Chats',
    'Users',
    'Setting',
  ];

  void changebottomnav(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

// ---------------------------------------- change mode

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changepasswordvisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(SocialPasswordVisibilityState());
  }

// ---------------------------------------- change mode
  bool isappmode = false;

  void onchangeappmode({bool? formShared}) {
    emit(ChangeThemeloadState());
    if (formShared != null) {
      isappmode = formShared;
      emit(ChangeThemeSuccessState());
    } else {
      isappmode = !isappmode;
      CacheHelper.saveData(key: 'Isdark', value: isappmode).then((value) {
        emit(ChangeThemeSuccessState());
      });
    }
  }

// ---------------------------------------- Translation
  void changeLanguage() async {
    isRtl = !isRtl;

    CacheHelper.saveData(key: 'isRtl', value: isRtl);
    String translation = await rootBundle
        .loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');
    setTranslation(
      translation: translation,
    );

    emit(ChangeLanguageState());
  }

  late TranslationModel translationModel;

  void setTranslation({
    required String translation,
  }) {
    translationModel = TranslationModel.fromJson(json.decode(
      translation,
    ));
    emit(LanguageLoaded());
  }

  // ------------------------------------ no internet

  bool noInternetConnection = false;

  void checkConnectivity() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      debugPrint('Internet Connection ------------------------');
      debugPrint('${result.index}');
      debugPrint(result.toString());
      if (result.index == 0 || result.index == 1) {
        noInternetConnection = false;
      } else if (result.index == 2) {
        noInternetConnection = true;
      }

      emit(InternetState());
    });
  }

  void checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      noInternetConnection = false;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      noInternetConnection = false;
    } else {
      noInternetConnection = true;
    }
    emit(InternetState());
  }
}
