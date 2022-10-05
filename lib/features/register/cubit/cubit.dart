import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/network/end_point.dart';
import 'package:firebase_chat/core/network/remote/dio_helper.dart';
import 'package:firebase_chat/core/usermodel/model.dart';
import 'package:firebase_chat/features/register/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) {
    emit(SocialRegisterLoadState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email,
        password: password)
        .then((value) {
      userCreate(uId: value.user!.uid,
          email: email,
          name: name,
          password: password,
          phone: phone );

    }).catchError((error) {
      print('Your Error${error.toString()}');
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
   required String email,
   required String password,
   required String name,
   required String phone,
   required String uId,
  }) {
    emit(SocialCreateUserLoadState());
    SocialUserModel model = SocialUserModel(
        name: name,
        phone: phone,
        email: email,
        password: password,
        uId: uId,
      isEmailVerfied: false
    );
    FirebaseFirestore.instance.collection('user').doc(uId)
        .set(model.toMap())
        .then((value) {
          emit(SocialCreateUserSuccessState());
    })
        .catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));

    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changepasswordvisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(SocialPasswordVisState());
  }
}
