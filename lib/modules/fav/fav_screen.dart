import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_final/bloc/cubit.dart';
import 'package:shop_app_final/bloc/states.dart';
import 'package:shop_app_final/core/components/components.dart';
import 'package:shop_app_final/models/fav_model.dart';
class FavScreen extends StatelessWidget {
  const FavScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener:(context,state){} ,
      builder: (context,state){
        var cubit = ShopAppCubit.get(context);
        return ListView.separated(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,                      //cubit.categoryModel!.data!.data![index]
          itemBuilder: (context,index)=>buildListProduct(cubit.favoritesModel!.data!.data![index].product,context),
          separatorBuilder: (context,index)=>Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(height: 5,color: Colors.red,),
          ),
          itemCount: cubit.favoritesModel!.data!.data!.length,

        );
      },

    );
  }


}
