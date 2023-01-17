abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialLoadGetUserSuccessState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
}

// --------------------  bottom navigation
class ChangeBottomNavState extends SocialStates{}

// --------------------  Profile PickImage --------
class SocialProfileImagePickedSuccessState extends SocialStates{}
class SocialProfileImagePickedErrorState extends SocialStates{}
// --------------------  Cover PickImage --------
class SocialCoverImagePickedSuccessState extends SocialStates{}
class SocialCoverImagePickedErrorState extends SocialStates{}
// -------------------- Remove Picked Image --------
class RemoveImageState extends SocialStates{}
// -------------------- Upload Profile PickImage --------
// class SocialUploadProfileImageSuccessState extends SocialStates{}
class SocialUploadProfileImageErrorState extends SocialStates{}
// --------------------  Cover PickImage --------
// class SocialUploadCoverImageSuccessState extends SocialStates{}
class SocialUploadCoverImageErrorState extends SocialStates{}
// --------------------  Updatedata --------
class SocialUpdateDataLoadingState extends SocialStates{}
class SocialUpdateDataErrorState extends SocialStates{}
// -------------------- Create Post --------
class SocialCreatePostLoadingState extends SocialStates{}
class SocialCreatePostSuccessState extends SocialStates{}
class SocialCreatePostErrorState extends SocialStates{
}
// -------------------- Get Post --------
class SocialGetPostsLoadingState extends SocialStates{}
class SocialGetPostsSuccessState extends SocialStates{}
class SocialGetPostsErrorState extends SocialStates{
  final String error;
  SocialGetPostsErrorState(this.error);
}
// -------------------- Get Likes --------
class SocialLikePostLoadingState extends SocialStates{}
class SocialLikePostSuccessState extends SocialStates{}
class SocialLikePostErrorState extends SocialStates{
  final String error;
  SocialLikePostErrorState(this.error);
}
// -------------------- Send Message --------
class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{
  final String error;
  SocialSendMessageErrorState(this.error);}
// -------------------- get Message --------

class SocialGetMessageSuccessState extends SocialStates{}
class SocialGetMessageErrorState extends SocialStates{
  final String error;
  SocialGetMessageErrorState(this.error);}
// -------------------- get All Users --------
class SocialGetAllUsersLoadingState extends SocialStates{}
class SocialGetAllUsersSuccessState extends SocialStates{}
class SocialGetAllUsersErrorState extends SocialStates{
  final String error;
  SocialGetAllUsersErrorState(this.error);
}
// -------------------- Pick postimage --------
class SocialPostImagePickedSuccessState extends SocialStates{}
class SocialPostImagePickedErrorState extends SocialStates{}
// --------------------  Screens --------
class SocialNewPostState extends SocialStates{}

// -------------------- PasswordVisibility
class SocialPasswordVisibilityState extends SocialStates {}


// -------------------- Translation

class ChangeLanguageState extends SocialStates {}

class LanguageLoaded extends SocialStates {}

// -------------------- no internet

class InternetState extends SocialStates {}


// ------------------------------------------language

class ChangeThemeloadState extends SocialStates {}

class ChangeThemeSuccessState extends SocialStates {}
class ChangeThemeErrorState extends SocialStates {}
