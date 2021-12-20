// ignore: import_of_legacy_library_into_null_safe
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/services/helper/url_launcher.dart';
import 'package:movies_app/services/local/cache_helper.dart';
import 'package:movies_app/translate/locale_keys.g.dart';
import 'package:movies_app/view_models/App_Cubit/cubit.dart';
import 'package:movies_app/view_models/Auth_Cubit/cubit.dart';
import 'package:movies_app/view_models/Auth_Cubit/states.dart';
import 'package:movies_app/views/auth_views/signup_view.dart';
import 'package:movies_app/views/layout_views/layout_view.dart';
import 'package:movies_app/views/teacher_auth_views/teacher_login_view.dart';
import 'package:movies_app/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sizer/sizer.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    TextEditingController _emailEditingController = TextEditingController();
    TextEditingController _passwordEditingController = TextEditingController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is LogInSuccessState) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              CacheHelper.saveData(key: "categorie", value: "user").then((value) {
                if (value) {
                  AppCubit.get(context).getCacheData();
                  navigateToAndFinish(
                    context,
                    LayoutView(),
                  );
                }
              });
            });
            showToast(text: "LogIn Success", state: ToastState.SUCCESS);
          } else if (state is LogInErrorState) {
            showToast(text: state.error.toString(), state: ToastState.ERROR);
          }
        },
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Image.asset('assets/images/cover.jpeg', width: double.infinity, height: 35.h, fit: BoxFit.cover,),
              Container(
                margin: EdgeInsets.only(top: 34.h),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 3.h,),
                        defaultFormField(
                            context: context,
                            controller: _emailEditingController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Your Email";
                              }
                              return null;
                            },
                            label: LocaleKeys.email.tr(),
                            prefix: Icons.email_outlined),
                        SizedBox(
                          height: 3.h,
                        ),
                        defaultFormField(
                            context: context,
                            controller: _passwordEditingController,
                            type: TextInputType.visiblePassword,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Password Is Too Short";
                              }
                              return null;
                            },
                            label: LocaleKeys.password.tr(),
                            prefix: Icons.lock_outline,
                            suffix: cubit.suffix,
                            suffixPressed: () {
                              cubit.changePasswordVisibility();
                            },
                            isPassword: cubit.isPassword),
                        SizedBox(
                          height: 4.h,
                        ),
                        ConditionalBuilder(
                          condition: state is! LogInLoadingState,
                          builder: (context) => defaultButton(
                              radius: 25,
                              function: () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.signIn(
                                      email: _emailEditingController.text,
                                      password: _passwordEditingController.text
                                  );
                                }
                              },
                              text: LocaleKeys.login.tr()),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            Text(LocaleKeys.doNotHave.tr(), style: Theme.of(context).textTheme.bodyText2,),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, RegisterView());
                                },
                                child: defaultTextField(
                                    size: 12.sp,
                                    text: LocaleKeys.register.tr(),
                                    color: kPrimaryColor)),
                          ],
                        ),
                        Divider(
                          thickness: 1.0,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            decoratedTextButton(text: LocaleKeys.joinAs.tr(), onPressed: () {
                              navigateTo(context, TeacherLoginView());
                            }, context: context),
                            decoratedTextButton(text: LocaleKeys.getHelp.tr(), onPressed: () async{
                              await Utils.openEmail(
                                toEmail: 'foxpes.kwt@outlook.com',
                                subject: 'Get Help',
                                body: '',
                              );
                            }, context: context),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
