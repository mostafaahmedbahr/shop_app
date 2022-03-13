import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_final/bloc/states.dart';
import 'package:shop_app_final/dio/dio_helper/dio_helper.dart';
import 'package:shop_app_final/dio/dio_helper/end_points.dart';
import 'package:shop_app_final/dio/sp_helper/cache_helper.dart';
import 'package:shop_app_final/models/category_model.dart';
import 'package:shop_app_final/models/change_favorites_model.dart';
import 'package:shop_app_final/models/fav_model.dart';
import 'package:shop_app_final/models/home_model.dart';
import 'package:shop_app_final/models/shop_login_model.dart';
import 'package:shop_app_final/modules/categories/categories.dart';
import 'package:shop_app_final/modules/fav/fav_screen.dart';
import 'package:shop_app_final/modules/products/products_screen.dart';
import 'package:shop_app_final/modules/settings/settings.dart';
import 'package:shop_app_final/new.dart';

class ShopAppCubit extends Cubit<ShopAppStates>
{
  ShopAppCubit() : super(ShopAppInitialState());

  static ShopAppCubit get(context)=>BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens =[
    ProductsScreen(),
    CategoriesScreen(),
    FavScreen(),
    SettingsScreen(),
  ];

  void changeBottomNav(int index)
  {
    currentIndex = index;
    emit(ShopAppChangeBottomNavBar());
  }

  HomeModel? homeModel;


  void getHomeData()
  {
    emit(ShopAppLoadingGetHomeDataState());
    DioHelper.getData(
        url: HOME,
      // مش متاكد انها صح الفيديو رقم 108 كورس عبدالله منصور
      token:  TOKEN,
    ).then((value)
    {
      print(value.data);

      homeModel = HomeModel.fromJson(value.data);
      // print(homeModel!.data!.banners![0].image);
      // print(homeModel!.status);
      homeModel!.data!.products!.forEach((element){
        favorites.addAll({
          element.id!:element.inFavorites!,
        });
      });

      emit(ShopAppSuccessGetHomeDataState());
    }).catchError((error){
      print("error in getHomeData ${error.toString()}");
      emit(ShopAppErrorGetHomeDataState());
    });
  }

  CategoryModel?  categoryModel;

  void getCategoryData()
  {
    emit(ShopAppLoadingGetHomeDataState());
    DioHelper.getData(
      url: CATEGORIES,
      // مش متاكد انها صح الفيديو رقم 108 كورس عبدالله منصور
      token:  TOKEN,
    ).then((value)
    {
      print(value.data);

      categoryModel = CategoryModel.fromJson(value.data);

      emit(ShopAppSuccessGetCategoryDataState());
    }).catchError((error){
      print("error in getCategoryData ${error.toString()}");
      emit(ShopAppErrorGetCategoryDataState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  Map <num ,dynamic> favorites ={};

  void changeFavorites(int productId)
  {
    favorites[productId] = !favorites[productId];
    emit(ShopAppSuccessChangeFavoritesState());
    DioHelper.postData(
        url: FAVORITES,
        data: {
          "product_id":productId,
        },
      token: TOKEN,
    ).then((value)
    {
      changeFavoritesModel = ChangeFavoritesModel.fromjson(value.data);
      print(value.data);
      if(!changeFavoritesModel!.status!)
      {
        favorites[productId] = !favorites[productId];
      }
      else {
        getFavData();
      }
      emit(ShopAppSuccessChangeFavoritesState());
    }).catchError((error)
    {
      favorites[productId] = !favorites[productId];
      print("error in changeFavorites ${error.toString()}");
      emit(ShopAppErrorChangeFavoritesState());
    });
  }

  FavoritesModel?  favoritesModel;
  void getFavData()
  {
     DioHelper.getData(
      url: FAVORITES,
      // مش متاكد انها صح الفيديو رقم 108 كورس عبدالله منصور
      token:  TOKEN,
    ).then((value)
    {
      print(value.data);

      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopAppSuccessGetFavoritesDataState());
    }).catchError((error){
      print("error in getFavoritesData ${error.toString()}");
      emit(ShopAppErrorGetFavoritesDataState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData()
  {
    emit(ShopAppLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      // مش متاكد انها صح الفيديو رقم 108 كورس عبدالله منصور
      token:  TOKEN,
    ).then((value)
    {
      print(value.data);
      userModel = ShopLoginModel.fromJson(value.data);

      emit(ShopAppSuccessUserDataState(userModel!));
    }).catchError((error){
      print("error in getUserData ${error.toString()}");
      emit(ShopAppErrorUserDataState());
    });
  }

  void upDateUserProfile({
    required String name,
    required String phone,
    required String email,
    required String password,

})
  {
    emit(ShopAppLoadingUpdateUserDataState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      // مش متاكد انها صح الفيديو رقم 108 كورس عبدالله منصور
      token:  TOKEN,
      data: {
        "name":name,
        "phone":phone,
        "email":email,
        "password":password,
      },
    ).then((value)
    {
      print(value.data);
      userModel = ShopLoginModel.fromJson(value.data);

      emit(ShopAppSuccessUpdateUserDataState(userModel!));
    }).catchError((error){
      print("error in upDateUserProfile ${error.toString()}");
      emit(ShopAppErrorUpdateUserDataState());
    });
  }



}