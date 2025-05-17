import 'package:dev_hub_cubit_session/blocs/auth/auth_cubit.dart';
import 'package:dev_hub_cubit_session/screens/cateogires_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if(state is AuthLoginSuccess)
            {
            //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CategoriesScreen()));
            }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Login')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [

                    TextFormField(
                      controller: context
                          .read<AuthCubit>()
                          .emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) =>
                      value == null || !value.contains('@')
                          ? 'Enter valid email'
                          : null,
                    ),
                    TextFormField(
                      controller: context
                          .read<AuthCubit>()
                          .passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password'),
                      validator: (value) =>
                      value == null || value.length < 6
                          ? 'Password too short'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {

                        print('login');
                         context.read<AuthCubit>().loginUser();

                      },
                      child: const Text('Login'),
                    ),

                    if(state is AuthLoginLoading)
                      LinearProgressIndicator(),

                    context.read<AuthCubit>().authModel==null? Text('')

                        :
                    Text('${context.read<AuthCubit>().authModel!.accessToken}')
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