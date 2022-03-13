import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_final/core/toast/toast.dart';
 import 'package:shop_app_final/core/toast/toast_states.dart';
import 'package:shop_app_final/core/utils/nav.dart';
import 'package:shop_app_final/dio/dio_helper/end_points.dart';
import 'package:shop_app_final/dio/sp_helper/cache_helper.dart';
import 'package:shop_app_final/modules/layout/shop_layout.dart';
import 'package:shop_app_final/modules/login/bloc/cubit.dart';
import 'package:shop_app_final/modules/login/bloc/states.dart';
import 'package:shop_app_final/modules/register/register.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailCon = TextEditingController();
    var passCon = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
           if(state is ShopLoginSuccessState)
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
        builder: (context, state) {
          var cubit = ShopLoginCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
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
                        Text("Login",
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),),
                        Text("Login to see our offers",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
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
                          height: 15.0,
                        ),
                        TextFormField(
                          onFieldSubmitted: (value)
                          {
                            if(formKey.currentState!.validate())
                            {
                              cubit.userLogin(
                                  email: emailCon.text,
                                  password: passCon.text);
                            };
                          },
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
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context)=> Container(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: (){
                                if(formKey.currentState!.validate())
                                {
                                  cubit.userLogin(
                                      email: emailCon.text,
                                      password: passCon.text);
                                };

                              },
                              child: Text("login",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Donot have an account ?"),
                            TextButton(
                              onPressed: (){
                                Navigator.push(context,
                                  MaterialPageRoute(
                                    builder: (context)=>RegisterScreen(),),);
                              },
                              child: Text("Register"),
                            ),
                          ],
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