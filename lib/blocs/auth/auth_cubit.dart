import 'package:bloc/bloc.dart';
import 'package:dev_hub_cubit_session/models/auth_model.dart';
import 'package:dev_hub_cubit_session/services/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());



  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();


  registerNewUser()
  {

    emit(AuthRegisterLoading());
    DioHelper.post('users',

        {
      "name": usernameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "avatar": "https://picsum.photos/800"
    },

        '')
        .then((value)
    {
      emit(AuthRegisterSuccess());
      print(value.statusCode);
      print(value.data);

    }
    ).catchError((error){
      emit(AuthRegisterError());
      print('error');
    });
  }


AuthModel? authModel;
  loginUser()
  {
    


    emit(AuthLoginLoading());
    DioHelper.post('auth/login',
        {
          "email": emailController.text,
          "password": passwordController.text
        },
        '').then((value){


          authModel=AuthModel.fromJson(value.data);

          print(authModel!.accessToken);


      emit(AuthLoginSuccess());
    }).catchError((error){
      print(error);
      emit(AuthLoginError());
    });
  }












}
