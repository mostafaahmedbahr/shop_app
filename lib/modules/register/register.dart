
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app_final/core/toast/toast.dart';
import 'package:shop_app_final/core/toast/toast_states.dart';
import 'package:shop_app_final/core/utils/nav.dart';
import 'package:shop_app_final/dio/dio_helper/end_points.dart';
import 'package:shop_app_final/dio/sp_helper/cache_helper.dart';
import 'package:shop_app_final/modules/layout/shop_layout.dart';
import 'package:shop_app_final/modules/login/login.dart';
import 'package:shop_app_final/modules/register/register_bloc/register_cubit.dart';
import 'package:shop_app_final/modules/register/register_bloc/register_states.dart';
class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailCon = TextEditingController();
  var passCon = TextEditingController();
  var nameCon = TextEditingController();
  var phoneCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context,state){
          if(state is ShopRegisterSuccessState)
          {
            if(state.loginModel.status==true)
            {
              // مهم
              TOKEN = state.loginModel.data!.token!;
              print(state.loginModel.data?.token);
              SharedPreferencesHelper.saveData(
                key: "token",
                value: state.loginModel.data?.token,
              );
              ToastConfig.showToast(
                msg: "${state.loginModel.message}",
                toastStates: ToastStates.Success,
              );
              AppNav.customNavigator(
                context: context,
                screen: ShopLayoutScreen(),
                finish: true,
              );
            }
            if(state.loginModel.status==false)
            {
              ToastConfig.showToast(
                msg: "${state.loginModel.message}",
                toastStates: ToastStates.Error,
              );

            }
            else
            {
              ToastConfig.showToast(
                msg: "${state.loginModel.message}",
                toastStates: ToastStates.Warning,
              );
            }
          }
        },
        builder: (context,state){
          var cubit = ShopRegisterCubit.get(context);
          return  Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios,
                color: Colors.black87,),
                onPressed: (){
                  AppNav.customNavigator(
                      context: context,
                      screen: ShopLoginScreen(),
                      finish: false,
                  );
                },
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Register",
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),),
                        Text("sign up to see our offers",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          controller: nameCon,
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return "name is must not be empty";
                            }
                          },
                          decoration: InputDecoration(
                            border:OutlineInputBorder(),
                            hintText: "name",
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
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
                            hintText: "email",
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          // onFieldSubmitted: (value)
                          // {
                          //   if(formKey.currentState!.validate())
                          //   {
                          //     cubit.userRegister(
                          //       name: nameCon.text,
                          //         phone: phoneCon.text,
                          //         email: emailCon.text,
                          //         password: passCon.text);
                          //   };
                          // },
                          obscureText: cubit.isVisible,
                          controller: passCon,
                          validator: (value){
                            if(value!.isEmpty)
                            {
                              return "password is too short";
                            }
                          },
                          decoration: InputDecoration(

                            border:OutlineInputBorder(),
                            hintText: "Password",
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: cubit.isVisible ? Icon(Icons.visibility_off):Icon(Icons.visibility),
                              onPressed: (){
                                cubit.changeSuffixIcon();
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: phoneCon,
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return "phone is must not be empty";
                            }
                          },
                          decoration: InputDecoration(
                            border:OutlineInputBorder(),
                            hintText: "phone",
                            prefixIcon: Icon(Icons.phone),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey[300],
                              ),
                              height: 50,
                              width: 50,
                              child: IconButton(
                                onPressed: (){},
                                icon: FaIcon(FontAwesomeIcons.facebookF),
                                color: Colors.blue,
                                iconSize: 30,),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey[300],
                              ),
                              height: 50,
                              width: 50,
                              child: IconButton(
                                onPressed: (){},
                                icon: FaIcon(FontAwesomeIcons.google),
                                color: Colors.blue,
                                iconSize: 30,),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey[300],
                              ),
                              height: 50,
                              width: 50,
                              child: IconButton(
                                onPressed: (){},
                                icon: FaIcon(FontAwesomeIcons.twitter),
                                color: Colors.blue,
                                iconSize: 30,),
                            ),

                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context)=> Container(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: (){
                                if(formKey.currentState!.validate())
                                {
                                  cubit.userRegister(
                                    name: nameCon.text,
                                      phone: phoneCon.text,
                                      email: emailCon.text,
                                      password: passCon.text);
                                };

                              },
                              child: Text("Register",
                                style: TextStyle(
                                  fontSize: 30,
                                ),),
                            ),
                          ),
                          fallback: (context)=>Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
