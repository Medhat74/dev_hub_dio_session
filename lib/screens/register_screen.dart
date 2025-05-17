import 'package:dev_hub_cubit_session/blocs/auth/auth_cubit.dart';
import 'package:dev_hub_cubit_session/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cateogires_screen.dart';


class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  void _register() {
    if (_formKey.currentState!.validate()) {
      // final username = _usernameController.text;
      // final email = _emailController.text;
      // final password = _passwordController.text;

      // For now, just print them
      // print('Username: $username');
      // print('Email: $email');
      // print('Password: $password');

      // You can later integrate this with your backend or Firebase
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {

          if(state is AuthRegisterSuccess)
            {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
            }

        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Register')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: context.read<AuthCubit>().usernameController ,
                      decoration: const InputDecoration(labelText: 'Username'),
                      validator: (value) =>
                      value == null || value.isEmpty ? 'Enter username' : null,
                    ),
                    TextFormField(
                      controller: context.read<AuthCubit>().emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) =>
                      value == null || !value.contains('@')
                          ? 'Enter valid email'
                          : null,
                    ),
                    TextFormField(
                      controller: context.read<AuthCubit>().passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password'),
                      validator: (value) =>
                      value == null || value.length < 6
                          ? 'Password too short'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: ()
                      {
                        context.read<AuthCubit>().registerNewUser();

                      },
                      child: const Text('Register'),
                    ),

                    if(state is AuthRegisterLoading)
                      LinearProgressIndicator(),


                    TextButton(onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    }, child: Text('Login !'))
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