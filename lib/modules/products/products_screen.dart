import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_final/bloc/cubit.dart';
import 'package:shop_app_final/bloc/states.dart';
import 'package:shop_app_final/models/category_model.dart';
import 'package:shop_app_final/models/home_model.dart';
class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context,state){},
        builder: (context,state){
        var cubit = ShopAppCubit.get(context);
        return  SingleChildScrollView(
          child: ConditionalBuilder(
              condition: cubit.homeModel != null&&cubit.categoryModel !=null,
              // state is !ShopAppLoadingGetHomeDataState,
              builder: (context)=>productsBuilder(cubit.homeModel!,cubit.categoryModel!,context),
              fallback: (context)=>Center(
                child: CircularProgressIndicator(),
              ),
          ),
        );
        },
    );
  }

  Widget productsBuilder(HomeModel model,CategoryModel categoryModel,context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data!.banners!.map((e)=>
                Image(image: NetworkImage("${e.image}"),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),).toList() ,
            options:  CarouselOptions(
              height: 250,
              scrollPhysics: BouncingScrollPhysics(),
              initialPage: 0,
              autoPlay: true,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayCurve: Curves.fastOutSlowIn,
              viewportFraction: 1,
            ),
          ),
          SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Categories",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(height: 10,),
                  Container(
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index)=>buildCategoryItem(categoryModel.data!.data![index],context),
                      separatorBuilder: (context,index)=>SizedBox(width: 5,),
                      itemCount: categoryModel.data!.data!.length,
                  ),
          ),
                  SizedBox(height: 10,),
                  Text("New Products",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),),
                ],
              ),
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 1/1.51,
                crossAxisSpacing: 1,
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                children:List.generate(
                  model.data!.products!.length,
                      (index) =>
                      buildGridProduct(model.data!.products![index],context ),
                ),
              ),
            ),
        ],
    );

  }

  Widget buildCategoryItem(DataModel dataModel,context)
  {
    return Container(
      height: 100,
      width: 100,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(image: NetworkImage(dataModel.image!),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black87.withOpacity(0.8),
            width: double.infinity,
            child: Text(dataModel.name!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),),
          ),
        ],
      ),
    );
  }

  Widget buildGridProduct(Products product,context)
  {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(image: NetworkImage(product.image!),
                width: double.infinity,
                height: 200,
               ),
              if(product.discount!=0)
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
         Padding(
           padding: const EdgeInsets.all(12.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(product.name!,
                 style: TextStyle(
                   fontSize: 14,
                   height: 1.3,
                 ),
                 maxLines: 2,
                 overflow: TextOverflow.ellipsis,
               ),
               Row(
                 children: [
                   Text("${product.price!.round()}",
                     style: TextStyle(
                       fontSize: 14,
                       color: Colors.blue,
                     ),
                   ),
                   Text(product.discount!=0? "${product.oldPrice!.round()}":"",
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
                         ShopAppCubit.get(context).changeFavorites(product.id);
                       },
                       icon: Icon(Icons.favorite,color:
                       ShopAppCubit.get(context).favorites[product.id]?Colors.red:Colors.white,),
                     ),
                   ),
                 ],
               ),
             ],
           ),
         ),
        ],
      ),
    );
  }
}
