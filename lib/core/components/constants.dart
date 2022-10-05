import 'package:firebase_chat/core/network/local/SharedPreferences.dart';
import 'package:flutter/material.dart';
import '../../translation.dart';
import '../cubit/cubit.dart';
import 'components.dart';

bool? isInProgress;
String? token;

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      showToast(
          message: 'Sign out Successfully', toastStates: ToastStates.SUCCESS);
    //  navigateFinish(context, LoginScreen());
    }
  });
}


void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

// ------------------- Translation
bool isRtl = false;
bool isDarkTheme = false;
TranslationModel appTranslation(context) => SocialCubit.get(context).translationModel;

String displayTranslatedText({
  required BuildContext context,
  required String ar,
  required String en,
}) => isRtl ? ar : en;

