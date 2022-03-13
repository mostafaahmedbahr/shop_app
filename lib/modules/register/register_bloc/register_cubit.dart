import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_final/dio/dio_helper/dio_helper.dart';
import 'package:shop_app_final/dio/dio_helper/end_points.dart';
import 'package:shop_app_final/models/shop_login_model.dart';
import 'package:shop_app_final/modules/login/bloc/states.dart';
import 'package:shop_app_final/modules/register/register_bloc/register_states.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  bool isVisible = true;
  ShopLoginModel? loginModel;

  void changeSuffixIcon()
  {
    isVisible =! isVisible;
    emit(ChangeSuffixIconRegisterState());
  }

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  })
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        "email":email,
        "password":password,
        "phone":phone,
        "name":name,
      },
    ).then((value)
    {
      print(value.data);
      loginModel= ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error)
    {
      print("function postData error ${error.toString()}");
      emit(ShopRegisterErrorState(error));
    });
  }

}