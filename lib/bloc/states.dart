import 'package:shop_app_final/models/shop_login_model.dart';
import 'package:shop_app_final/modules/login/login.dart';

abstract class ShopAppStates{}

class ShopAppInitialState extends ShopAppStates{}

class ShopAppChangeBottomNavBar extends ShopAppStates{}

class ShopAppLoadingGetHomeDataState extends ShopAppStates{}

class ShopAppSuccessGetHomeDataState extends ShopAppStates{}

class ShopAppErrorGetHomeDataState extends ShopAppStates{}

class ShopAppSuccessGetCategoryDataState extends ShopAppStates{}

class ShopAppErrorGetCategoryDataState extends ShopAppStates{}

class ShopAppSuccessChangeFavoritesState extends ShopAppStates{}

class ShopAppErrorChangeFavoritesState extends ShopAppStates{}

class ShopAppSuccessGetFavoritesDataState extends ShopAppStates{}

class ShopAppErrorGetFavoritesDataState extends ShopAppStates{}

class ShopAppLoadingUserDataState extends ShopAppStates{}

class ShopAppSuccessUserDataState extends ShopAppStates{
  ShopLoginModel loginModel;
  ShopAppSuccessUserDataState(this.loginModel);
}

class ShopAppErrorUserDataState extends ShopAppStates{}

class ShopAppLoadingUpdateUserDataState extends ShopAppStates{}

class ShopAppSuccessUpdateUserDataState extends ShopAppStates{
  ShopLoginModel loginModel;
  ShopAppSuccessUpdateUserDataState(this.loginModel);
}

class ShopAppErrorUpdateUserDataState extends ShopAppStates{}
