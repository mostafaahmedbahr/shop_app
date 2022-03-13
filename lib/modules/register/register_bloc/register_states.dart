import 'package:shop_app_final/models/shop_login_model.dart';

abstract class ShopRegisterStates{}

class ShopRegisterInitialState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}

class ShopRegisterErrorState extends ShopRegisterStates{
  final String error;
  ShopRegisterErrorState(this.error);
}

class ShopRegisterSuccessState extends ShopRegisterStates{
  ShopLoginModel loginModel;
  ShopRegisterSuccessState(this.loginModel);
}

class ChangeSuffixIconRegisterState extends ShopRegisterStates{}