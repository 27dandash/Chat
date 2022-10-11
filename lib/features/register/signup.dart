import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../core/components/components.dart';
import '../../core/components/constants.dart';
import '../home/home_screen.dart';
import '../login/cubit/cubit.dart';
import '../login/login_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if(state is SocialCreateUserSuccessState){
            navigateFinish(context, HomeLayOut());
            showToast(toastStates: ToastStates.SUCCESS, message:appTranslation(context).logindone);
          }
          if(state is SocialCreateUserErrorState){
            showToast(toastStates: ToastStates.SUCCESS, message:state.error);
          }
        },
        builder: (context, state) {
          return Directionality(
            textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,

            child: Scaffold(
              body: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appTranslation(context).register,
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          defaultFormField(
                            controller: _nameController,
                            label: appTranslation(context).username,
                            prefix: Icons.person,
                            type: TextInputType.name,
                            validate: (String ? value) {
                              if (value!.isEmpty) {
                                return 'User Name must not be empty';
                              }

                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                            controller: _emailController,
                            label: appTranslation(context).email,
                            prefix: Icons.email,
                            type: TextInputType.emailAddress,
                            validate: (String ? value) {
                              if (value!.isEmpty) {
                                return 'email must not be empty';
                              }

                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                            controller: _phoneController,
                            label:  appTranslation(context).phone,
                            prefix: Icons.phone,
                            type: TextInputType.phone,
                            validate: (String ? value) {
                              if (value!.isEmpty) {
                                return 'Phone Number must not be empty';
                              }

                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                            controller: _passwordController,
                            onSubmit: (value) {
                              // if (formKey.currentState.validate()) {
                              //   ShopLoginCubit.get(context).userlogin(
                              //       email: _nameController.text,
                              //       password: _passwordController.text);
                              // }
                            },
                            label:  appTranslation(context).pass,
                            prefix: Icons.lock,
                            // isPassword: ShopLoginCubit.get(context).isPassword,
                            // suffix: ShopLoginCubit.get(context).suffix,
                            // suffixPressed: (){
                            // ShopLoginCubit.get(context).changepasswordvisibility();
                            // },
                            suffix: SocialRegisterCubit.get(context).suffix,

                            type: TextInputType.visiblePassword,
                            validate: (String ? value) {
                              if (value!.isEmpty) {
                                return 'You have To enter Password';
                              }

                              return null;
                              //'You Password is wrong';
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ConditionalBuilder(
                              condition: state is ! SocialRegisterLoadState,
                              builder: (context) => defaultButton(
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        SocialRegisterCubit.get(context)
                                            .userRegister(

                                                email: _emailController.text,
                                                name: _nameController.text,
                                                phone: _phoneController.text,
                                                password:
                                                    _passwordController.text);
                                      }
                                    },
                                    text:  appTranslation(context).register,
                                    isUpperCase: true,
                                  ),
                              fallback: (context) =>
                                  Center(child: CircularProgressIndicator())),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  appTranslation(context).yse_account,
                              ),
                              TextButton(
                                onPressed: () {
                                  navigateTo(context, LoginScreen());
                                },
                                child: Text(
                                  appTranslation(context).register,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
