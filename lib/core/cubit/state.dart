
abstract class SocialStates  {}

class SocialInitialState extends SocialStates {}

class LoginLoadingState extends SocialStates {}

class LoginSuccessState extends SocialStates {
}

class LoginChangePasswordState extends SocialStates {}

class LoginErrorState extends SocialStates {
  final String? error;
  LoginErrorState(this.error);
}

// -------------------- Translation

class ChangeLanguageState extends SocialStates {}

class LanguageLoaded extends SocialStates {}

// -------------------- no internet

class InternetState extends SocialStates {}




