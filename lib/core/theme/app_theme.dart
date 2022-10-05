import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'app_colors.dart';
import 'app_radius.dart';

class AppTheme {
  ThemeData lightTheme = ThemeData();
  ThemeData darkTheme = ThemeData();

  AppTheme() {
    lightTheme = ThemeData(
        dialogTheme: DialogTheme(backgroundColor: AppColors.primary),
        primaryColor: AppColors.primary,
        hintColor: AppColors.hint,
        textTheme: TextTheme(
            bodyText1: TextStyle(color: AppColors.text, fontSize: 18),
            headline1: TextStyle(color: AppColors.text, fontSize: 22),
            bodyText2: TextStyle(color: AppColors.text, fontSize: 16)),
        disabledColor: Colors.grey,
        fontFamily: null,
        inputDecorationTheme: getBorderedInputDecoration(),
        scaffoldBackgroundColor: HexColor('#F9F9F9'),
        cardColor: AppColors.card,
        appBarTheme: getAppBarTheme(),
        textButtonTheme: getTextButtonDarkTheme(),
        iconTheme: IconThemeData(color: AppColors.icon, size: 25),
        cardTheme: getCardTheme(),
        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.button,
          disabledColor: AppColors.disableButton,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppRadius.button),
            ),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.icon,
          selectedLabelStyle: TextStyle(color: AppColors.text),
          unselectedItemColor: AppColors.icon,
          selectedIconTheme: IconThemeData(color: AppColors.icon, size: 25),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: AppColors.floatingActionButton),
        dividerColor: AppColors.text);
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////// const LinearGradient(
    //         begin: Alignment.topLeft,
    //         end: Alignment.bottomRight,
    //         stops: [0.2, 0.5, 0.7, 1],
    //         colors: [Colors.black12, Colors.grey, Colors.black54, Colors.black45])
    // ),
    /////////////////////////////////////////////////////////////////////////////////////////
    darkTheme = ThemeData(
        primaryColor: AppColors.primaryDark,
        hintColor: AppColors.hint,
        dialogTheme: DialogTheme(backgroundColor: AppColors.primaryDark),
        disabledColor: Colors.grey,
        textTheme: TextTheme(
            bodyText1: TextStyle(color: AppColors.textDark, fontSize: 18),
            headline1: TextStyle(color: AppColors.textDark, fontSize: 22),
            bodyText2: TextStyle(color: AppColors.textDark, fontSize: 16)),
        fontFamily: null,
        cardColor: AppColors.cardDark,
        inputDecorationTheme: getBorderedInputDecoration(),
        scaffoldBackgroundColor: Colors.grey.shade800,
        appBarTheme: getAppBarDarkTheme(),
        textButtonTheme: getTextButtonDarkTheme(),
        iconTheme: IconThemeData(color: AppColors.iconDark),
        cardTheme: getCardDarkTheme(),
        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.buttonDark,
          disabledColor: AppColors.disableButton,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppRadius.button),
            ),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.grey.shade900,
            selectedItemColor: AppColors.iconDark,
            unselectedItemColor: Colors.grey,
            selectedIconTheme:
                IconThemeData(color: AppColors.iconDark, size: 25),
            selectedLabelStyle: TextStyle(color: AppColors.textDark)),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: AppColors.floatingActionButtonDark),
        dividerColor: AppColors.textDark,
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.primaryDark,
        ));
  }

  InputDecorationTheme getBorderedInputDecoration() {
    return InputDecorationTheme(
      labelStyle: TextStyle(
        color: AppColors.label,
      ),
      prefixIconColor: AppColors.textFormFieldIcon,
      suffixIconColor: AppColors.textFormFieldIcon,
      border: const OutlineInputBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(AppRadius.textFormField)),
      ),
    );
  }

  CardTheme getCardTheme() {
    return CardTheme(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      //margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      clipBehavior: Clip.antiAlias,
      color: AppColors.card,
    );
  }

  CardTheme getCardDarkTheme() {
    return CardTheme(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      //margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      clipBehavior: Clip.antiAlias,
      color: AppColors.cardDark,
    );
  }

  AppBarTheme getAppBarTheme() {
    return AppBarTheme(
      color: AppColors.appBar,
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppColors.appBarIcon,
      ),
    );
  }

  AppBarTheme getAppBarDarkTheme() {
    return AppBarTheme(
      color: AppColors.appBarDark,
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppColors.appBarIconDark,
      ),
    );
  }

  TextButtonThemeData getTextButtonTheme() {
    return TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(AppColors.textButton),
      ),
    );
  }

  TextButtonThemeData getTextButtonDarkTheme() {
    return TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(AppColors.textButtonDark),
      ),
    );
  }
}
