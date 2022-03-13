 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_final/bloc/cubit.dart';
import 'package:shop_app_final/core/utils/nav.dart';
import 'package:shop_app_final/dio/sp_helper/cache_helper.dart';
import 'package:shop_app_final/models/fav_model.dart';
import 'package:shop_app_final/modules/login/login.dart';
import 'package:shop_app_final/modules/on_boarding_screen/on_boarding_screen.dart';

void SignOut(BuildContext context)
{
  SharedPreferencesHelper.removeData(
      key: "token").then((value)
  {
    if(value)
    {
      AppNav.customNavigator(
        context: context,
        screen: OnBoardingScreen(),
        finish: true,
      );
    }
  });
}

 Widget buildListProduct(model,context,{isOldPrice = true})
 {
   return Padding(
     padding: const EdgeInsets.all(20.0),
     child: Container(
       height: 120,
       child: Row(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Stack(
             alignment: AlignmentDirectional.bottomStart,
             children: [
               Image(image: NetworkImage("${model.image}"),
                 width: 120,
                 height: 120,
               ),
               if(model.discount!=0&&isOldPrice)
                 Container(
                   color: Colors.red,
                   padding: EdgeInsets.symmetric(horizontal: 5),
                   child: Text( "DISCOUNT",
                     style: TextStyle(
                       fontSize: 12,
                       color: Colors.white,
                     ),),
                 ),
             ],
           ),
           SizedBox(width: 20,),
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text("${model.name}",
                   style: TextStyle(
                     fontSize: 14,
                     height: 1.3,
                   ),
                   maxLines: 2,
                   overflow: TextOverflow.ellipsis,
                 ),
                 Spacer(),
                 Row(
                   children: [
                     Text("${model.price}",
                       style: TextStyle(
                         fontSize: 14,
                         color: Colors.blue,
                       ),
                     ),
                     Text(model.discount!=0&&isOldPrice?"${model.oldPrice!}":"",
                       style: TextStyle(
                         fontSize: 10,
                         color: Colors.grey,
                         decoration: TextDecoration.lineThrough,
                       ),
                     ),
                     Spacer(),
                     CircleAvatar(
                       child: IconButton(
                         onPressed: (){
                           ShopAppCubit.get(context).changeFavorites(
                               model.id!
                           );
                         },
                         icon: Icon(Icons.favorite,
                           color: ShopAppCubit.get(context).favorites[model.id]?Colors.red:Colors.white,
                         ),
                       ),
                     ),
                   ],
                 ),
               ],
             ),
           ),
         ],
       ),
     ),
   );
 }