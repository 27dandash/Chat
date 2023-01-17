import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'app_colors.dart';
import 'app_radius.dart';

class AppTheme {
  ThemeData lightTheme = ThemeData();
  ThemeData darkTheme = ThemeData();

  AppTheme() {
    lightTheme = ThemeData(
      primarySwatch: Colors.deepOrange,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        titleSpacing: 20.0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.blue,
        elevation: 0.0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(

          color: Colors.black,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.deepOrange,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        elevation: 20.0,
        backgroundColor: Colors.white,
      ),
      textTheme: const TextTheme(
        bodyText1: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
    // ##########################################################################
    // const LinearGradient(
    //          begin: Alignment.topLeft,
    //          end: Alignment.bottomRight,
    //          stops: [0.2, 0.5, 0.7, 1],
    //          colors: [Colors.black12, Colors.grey, Colors.black54, Colors.black45]);
    // ##########################################################################

    darkTheme = ThemeData(
      primarySwatch: Colors.deepOrange,
      scaffoldBackgroundColor: HexColor('333739'),
      appBarTheme: AppBarTheme(
        titleSpacing: 20.0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: HexColor('333739'),
        elevation: 0.0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.deepOrange,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        elevation: 20.0,
        backgroundColor: HexColor('333739'),
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  InputDecorationTheme getBorderedInputDecoration() {
    return InputDecorationTheme(
      labelStyle: TextStyle(
        color: AppColors.label,
      ),
      prefixIconColor: AppColors.textFormFieldIcon,
      suffixIconColor: AppColors.textFormFieldIcon,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.textFormField)),
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


