import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_final/dio/dio_helper/dio_helper.dart';
 import 'package:shop_app_final/dio/dio_helper/end_points.dart';
 import 'package:shop_app_final/models/shop_login_model.dart';
import 'package:shop_app_final/modules/login/bloc/states.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
   ShopLoginCubit() : super(ShopLoginInitialState());

   static ShopLoginCubit get(context) => BlocProvider.of(context);

   bool isVisible = true;
   ShopLoginModel? loginModel;

   void changeSuffixIcon()
   {
      isVisible =! isVisible;
      emit(ChangeSuffixIconState());
   }

   void userLogin({
   required String email,
      required String password,
})
   {
      emit(ShopLoginLoadingState());
      DioHelper.postData(
          url: LOGIN,
          data: {
             "email":email,
             "password":password,
          },
      ).then((value)
      {
         print(value.data);
         loginModel= ShopLoginModel.fromJson(value.data);
         emit(ShopLoginSuccessState(loginModel!));
      }).catchError((error)
      {
         print("function postData error ${error.toString()}");
         emit(ShopLoginErrorState(error));
      });
   }

}