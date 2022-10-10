import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/features/login/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userlogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.displayName);
      print(value.user!.uid);
      //  loginModel= SocialLoginModel.fromjson(value.data);
      //   print(loginModel.data.token);
      //    print(loginModel.message);

      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      //       print(error.toString());
      //       print('dddddddddddddddddddddddddddd');

      emit(SocialLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changepasswordvisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(SocialLoginPasswordVisibilityState());
  }
}
