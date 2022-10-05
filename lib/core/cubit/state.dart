abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialLoadGetUserSuccessState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
}

// -------------------- Translation

class ChangeLanguageState extends SocialStates {}

class LanguageLoaded extends SocialStates {}

// -------------------- no internet

class InternetState extends SocialStates {}


// ------------------------------------------language

class ChangeThemeloadState extends SocialStates {}

class ChangeThemeSuccessState extends SocialStates {}
class ChangeThemeErrorState extends SocialStates {}
