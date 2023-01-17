import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/components/constants.dart';
import 'package:firebase_chat/core/cubit/state.dart';
import 'package:firebase_chat/core/models/message_model.dart';
import 'package:firebase_chat/core/models/user_model.dart';
import 'package:firebase_chat/core/network/local/SharedPreferences.dart';
import 'package:firebase_chat/features/feeds/feeds%20screen.dart';
import 'package:firebase_chat/features/schats/chats%20screen.dart';
import 'package:firebase_chat/features/setting/setting%20screen.dart';
import 'package:firebase_chat/features/users/users%20screen.dart';
import 'package:firebase_chat/translation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../features/new_post/new_post.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/post_model.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

// ----------------------------------------- bottom navigation
  int currentIndex = 0;
  List<Widget> bottomScreen = [
    const FeedsScreen(),
    const ChatsScreen(),
    NewPostScreen(),
    const UsersScreen(),
    const SettingScreen(),
  ];
  List<String> Titels = [
    'Home',
    'Chats',
    'Posts',
    'Users',
    'Setting',
  ];

  void Changebottomnav(int index) {
    if (index == 1) {
      getUsers();
    }
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;

      emit(ChangeBottomNavState());
    }
  }

// ---------------------------------------- changepasswordvisibility
  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changepasswordvisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(SocialPasswordVisibilityState());
  }

// ----------------------------------------- AppTheme
  bool AppTheme = false;

  void onchangeappmode({bool? formShared}) {
    emit(ChangeThemeloadState());
    if (formShared != null) {
      AppTheme = formShared;
      emit(ChangeThemeSuccessState());
    } else {
      AppTheme = !AppTheme;
      CacheHelper.saveData(key: 'Isdark', value: AppTheme).then((value) {
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

  UserModel? userModel;
  PostModel? postModel;

// ----------------------------------------- getUserData
  void getUserData() {
    emit(SocialLoadGetUserSuccessState());
    FirebaseFirestore.instance
        .collection('user')
        .doc(token)
        .get()
        .then((value) {
      print('============data=============${value.data()!}');
      userModel = UserModel.fromJson(value.data()!);
      print('============img=============');
      print(userModel!.img);
      print(userModel!.uId);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

// ----------------------------------------- get $ pick profileimage
  final picker = ImagePicker();

  File? profileimage;

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileimage = File(pickedFile.path);
      print('#################################3');
      print(profileimage!.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

// ----------------------------------------- get $ pick coverimage
  File? coverImage;

  Future<void> getcoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print('#################################3');
      print(profileimage!.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No Image Selected');

      emit(SocialCoverImagePickedErrorState());
    }
  }

// ----------------------------------------- uploadprofileImage
  void uploadprofileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri
        .file(profileimage!.path)
        .pathSegments
        .last}')
        .putFile(profileimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, img: value);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());

        print(error.toString());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());

      print(error.toString());
    });
  }

/*
// -----^&&&(********------------------------------------ upload image in other way
  // void uploadImage() async {
  //   print('_uploadImage -----------------');
  //   try {
  //     await FirebaseStorage.instance
  //         .ref('profileImages/${model!.uId}')
  //         .putFile(profileimage!);
  //     print('!!!!!!!!!!!!!uId!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
  //
  //     print(model!.uId);
  //     // _getImageUrl();
  //   } on FirebaseException catch (e) {
  //     print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
  //     print(e.toString());
  //   }
  // }

  // void _getImageUrl() async {
  //   print('_getImageUrl -----------------');
  //   imageUrl = await FirebaseStorage.instance
  //       .ref('profileImages/$uId')
  //       .getDownloadURL();
  //   userCreate();
  // }
 */

// ----------------------------------------- uploadcoverImage
  void uploadcoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri
        .file(coverImage!.path)
        .pathSegments
        .last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());

        print(error.toString());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());

      print(error.toString());
    });
  }

// ----------------------------------------- remove Post Image

  void removePostImage() {
    postimage = null;
    emit(RemoveImageState());
  }

// ----------------------------------------- UpdateUserData
  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? img,
    String? cover,
  }) {
    UserModel model = UserModel(
        name: name,
        phone: phone,
        bio: bio,
        email: userModel!.email,
        img: img ?? userModel!.img,
        coverimg: cover ?? userModel!.coverimg,
        password: userModel!.password,
        uId: userModel!.uId,
        isEmailVerfied: false);
    FirebaseFirestore.instance
        .collection('user')
        .doc(model.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      print(error.toString());
      emit(SocialUpdateDataErrorState());
    });
  }

  /*
  // void updateUserImage({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialUpdateDataLoadingState());
  //   if (coverImage != null)
  //   {
  //     _uploadprofileImage();
  //   }
  //   else if (profileimage != null)
  //   {
  //     _uploadcoverImage();
  //   }
  //   else if (coverImage != null && profileimage != null)
  //   {
  //
  //   }
  //   else
  //   {
  //     updateUser(name: name, phone: phone, bio: bio);
  //   }
  // }
*/

// ----------------------------------------- createNewPost

  File? postimage;

  Future<void> getpostimage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postimage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri
        .file(postimage!.path)
        .pathSegments
        .last}')
        .putFile(postimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadCoverImageSuccessState());
        print(value);
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
        print(error.toString());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());

      print(error.toString());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel!.name,
      img: userModel!.img,
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreatePostErrorState());
    });
  }

// ----------------------------------------- get Posts

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromMap(element.data()));
        }).catchError((onError) {});
      });
      print('===============value==================');
      print(value.docs[1].data());
      emit(SocialGetPostsSuccessState());
      print('1111111111111posts22222222222');
      print(value.docs[0].data());
      print('===========postModelname==============${posts[0].dateTime}');
      print('===========postModelname==============${posts[1].text}');
    }).catchError((onError) {
      emit(SocialGetPostsErrorState(onError.toString()));
      print('===============Error=================${onError.toString()}');
    });
  }

/*
// void getPosts() {
//
//   FirebaseFirestore.instance.collection('Posts').get().then((value) {
//     // value.docs.forEach((element) {
//     //   posts.add(PostModel.fromJson(element.data()));
//     // // });
//     // });
//     print('===============value==================');
//     print(value.docs[0].data());
//     emit(SocialGetPostsSuccessState());
//
//   })
//       .catchError((onError) {
//     print('===============Error==================');
//     emit(SocialGetPostsErrorState(onError.toString()));
//     print(onError.toString());
//   });
// }
 */
// ----------------------------------------- get Likes
  void likePostes(String PostId) {
    FirebaseFirestore.instance
        .collection('posts')
    // اي لاومه ال doc
        .doc(PostId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((onError) {
      emit(SocialLikePostErrorState(onError.toString()));
      print(onError.toString());
    });
  }

// -------------------- get All Users --------
  List<UserModel> users = [];

  void getUsers() {
    // if(users.length==0)   users بردو بنفي ليسته
    users = [];
    FirebaseFirestore.instance.collection('user').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != userModel!.uId) {
          users.add(UserModel.fromJson(element.data()));
        }
      });
      emit(SocialGetAllUsersSuccessState());
    }).catchError((onError) {
      emit(SocialGetAllUsersErrorState(onError.toString()));
      print(onError.toString());
    });
  }

// -------------------- send Message  --------
  void sendMessage({
    required String recivreId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      text: text,
      dateTime: dateTime,
      recivreId: recivreId,
      senderId: userModel!.uId,
    );
    FirebaseFirestore.instance
        .collection('user')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(recivreId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((onError) {
      emit(SocialSendMessageErrorState(onError.toString()));
    });
    FirebaseFirestore.instance
        .collection('user')
        .doc(recivreId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((onError) {
      emit(SocialSendMessageErrorState(onError.toString()));
    });
  }

// -------------------- Get Message  --------
  List <MessageModel>messages = [];
//جرب ترفع صوره ف صقحه الشات وتبعتها
  void getMessages({ required String recivreId,}) {
    FirebaseFirestore.instance.collection('user').doc(userModel!.uId)
        .collection('chats')
        .doc(recivreId)
        .collection('messages')
    //بترتب  حسب ال Date Time
    .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages=[];
          event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
          });
          emit(SocialGetMessageSuccessState());
    });
  }

}
