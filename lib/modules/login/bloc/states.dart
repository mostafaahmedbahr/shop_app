import 'package:shop_app_final/models/shop_login_model.dart';

abstract class ShopLoginStates{}

class ShopLoginInitialState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}

class ShopLoginErrorState extends ShopLoginStates{
  final String error;
  ShopLoginErrorState(this.error);
}

class ShopLoginSuccessState extends ShopLoginStates{
  ShopLoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);
}

class ChangeSuffixIconState extends ShopLoginStates{}