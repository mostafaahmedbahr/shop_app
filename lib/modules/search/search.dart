import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_final/core/components/components.dart';
import 'package:shop_app_final/modules/search/bloc/cubit.dart';
import 'package:shop_app_final/modules/search/bloc/states.dart';
class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=>SearchCubit(),
        child: BlocConsumer<SearchCubit,SearchStates>(
          listener: (context,state){},
          builder: (context,state){
            var cubit = SearchCubit.get(context);
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios,
                  color: Colors.black87,),
                ),
              ),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: searchCon,
                        onFieldSubmitted: (value)
                        {
                          if(formKey.currentState!.validate())
                          {
                            cubit.search(
                                text: searchCon.text,
                            );
                          }
                        },
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return "enter text to search";
                          }
                        },
                        decoration: InputDecoration(
                          border:OutlineInputBorder(),
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                      SizedBox(height: 10,),
                      if(state is SearchLoadingState)
                        LinearProgressIndicator(),
                      SizedBox(height: 10,),
                      if(state is SearchSuccessState)
                        Expanded(
                          child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,                      //cubit.categoryModel!.data!.data![index]
                            itemBuilder: (context,index)=>buildListProduct(cubit.searchModel!.data!.data[index],context,isOldPrice: false),
                            separatorBuilder: (context,index)=>Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(height: 5,color: Colors.red,),
                            ),
                            itemCount: cubit.searchModel!.data!.data.length,

                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },


      ),
    );
  }
}
