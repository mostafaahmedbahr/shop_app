import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_final/bloc/cubit.dart';
 import 'package:shop_app_final/dio/dio_helper/dio_helper.dart';
import 'package:shop_app_final/dio/sp_helper/cache_helper.dart';
 import 'modules/login/login.dart';
import 'modules/on_boarding_screen/on_boarding_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  DioHelper.init();
  runApp(  MyApp(
    onBoarding : false,
   ));
}
class MyApp extends StatelessWidget {
  final bool onBoarding;
   // token = SharedPreferencesHelper.getData(key:"token");
     MyApp({required this.onBoarding});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ShopAppCubit()..getHomeData()..getCategoryData()..getFavData()..getUserData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: onBoarding? ShopLoginScreen() : OnBoardingScreen(),
      ),
    );
  }
}
