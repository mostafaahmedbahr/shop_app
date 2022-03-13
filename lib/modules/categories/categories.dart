import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_final/bloc/cubit.dart';
import 'package:shop_app_final/bloc/states.dart';
import 'package:shop_app_final/models/category_model.dart';
class  CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = ShopAppCubit.get(context);
        return ListView.separated(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
           scrollDirection: Axis.vertical,
          itemBuilder: (context,index)=>buildCartItem(cubit.categoryModel!.data!.data![index]),
          separatorBuilder: (context,index)=>SizedBox(height: 10,),
          itemCount:cubit.categoryModel!.data!.data!.length,
        );
      },
    );
  }
  // DataModel dataModel
  Widget buildCartItem(DataModel dataModel)
  {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(image: NetworkImage(dataModel.image!),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10,),
          Text(dataModel.name!,
          style: TextStyle(
            fontSize: 25,
          ),),
          Spacer(),
          IconButton(onPressed: (){},
              icon: Icon(Icons.arrow_forward_ios,),
          ),
        ],
      ),
    );
  }
}
