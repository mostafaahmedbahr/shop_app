import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_final/bloc/cubit.dart';
import 'package:shop_app_final/bloc/states.dart';
import 'package:shop_app_final/core/components/components.dart';
class SettingsScreen extends StatelessWidget {
  var emailCon = TextEditingController();
  var nameCon = TextEditingController();
  var phoneCon = TextEditingController();
  var passCon = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context,state){
        if(state is ShopAppSuccessUserDataState)
        {
          emailCon.text = state.loginModel.data!.name!;
        }
      },
      builder: (context,state){
        var cubit = ShopAppCubit.get(context);
        nameCon.text = cubit.userModel!.data!.name!;
        emailCon.text = cubit.userModel!.data!.email!;
        phoneCon.text = cubit.userModel!.data!.phone!;

        return ConditionalBuilder(
          condition: cubit.userModel !=null,
          builder: (context)=>Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  // if(state is ShopAppLoadingUpdateUserDataState)
                  // LinearProgressIndicator(),
                  // SizedBox(
                  //   height: 15.0,
                  //z ),
                  TextFormField(
                    controller: nameCon,
                    keyboardType: TextInputType.name,
                    validator: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return "name is must not be empty";
                      }
                    },
                    decoration: InputDecoration(
                      border:OutlineInputBorder(),
                      hintText: "Name",
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailCon,
                    validator: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return "email is must not be empty";
                      }
                    },
                    decoration: InputDecoration(
                      border:OutlineInputBorder(),
                      hintText: "email Address",
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: phoneCon,
                    keyboardType: TextInputType.phone,
                    validator: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return "phone is must not be empty";
                      }
                    },
                    decoration: InputDecoration(
                      border:OutlineInputBorder(),
                      hintText: "Phone",
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: passCon,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return "password is must not be empty";
                      }
                    },
                    decoration: InputDecoration(
                      border:OutlineInputBorder(),
                      hintText: "password",
                      prefixIcon: Icon(Icons.password),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (){
                        if(formKey.currentState!.validate())
                        {
                          cubit.upDateUserProfile(
                            name: nameCon.text
                            , phone: phoneCon.text,
                            email: emailCon.text,
                            password: passCon.text,
                          );
                        }
                      },
                      child: Text("Update",
                        style: TextStyle(
                          fontSize: 30,
                        ),),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (){
                        SignOut(context);
                      },
                      child: Text("logout",
                        style: TextStyle(
                          fontSize: 30,
                        ),),
                    ),
                  ),

                ],
              ),
            ),
          ),
          fallback:(context)=> Center(
            child: CircularProgressIndicator(),
          ),

        );
      },

    );
  }
}
