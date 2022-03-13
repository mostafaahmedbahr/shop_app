import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_final/bloc/cubit.dart';
import 'package:shop_app_final/bloc/states.dart';
import 'package:shop_app_final/core/components/components.dart';
import 'package:shop_app_final/core/utils/nav.dart';
import 'package:shop_app_final/dio/sp_helper/cache_helper.dart';
import 'package:shop_app_final/modules/login/login.dart';
import 'package:shop_app_final/modules/search/search.dart';
 class ShopLayoutScreen extends StatefulWidget {
  const ShopLayoutScreen({Key? key}) : super(key: key);

  @override
  State<ShopLayoutScreen> createState() => _ShopLayoutScreenState();
}

class _ShopLayoutScreenState extends State<ShopLayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = ShopAppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text("Salla",
            style: TextStyle(
              color: Colors.black87,
            ),),
            actions: [
              IconButton(
                onPressed: (){
                  AppNav.customNavigator(
                      context: context,
                      screen: SearchScreen(),
                      finish: false,
                  );
                },
                  icon: Icon(Icons.search,color: Colors.black87,),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                //  TextButton(
                //   onPressed:(){
                //     SignOut(context);
                //   },
                //   child: Text("Sign out"),
                // ),
                cubit.screens[cubit.currentIndex],

              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                icon:Icon(Icons.home),
                label: "products",
              ),
              BottomNavigationBarItem(
                icon:Icon(Icons.category_outlined),
                label: "Categories",
              ),
              BottomNavigationBarItem(
                icon:Icon(Icons.favorite),
                label: "Favorites",
              ),
              BottomNavigationBarItem(
                icon:Icon(Icons.settings),
                label: "Settings",
              ),
            ],
          ),
        );
      },

    );
  }
}
