import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/main.dart';
import 'package:movies_app/translations/locale_keys.g.dart';
import 'package:movies_app/widgets/custom_text.dart';
import 'package:movies_app/widgets/custom_navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/view_models/Auth_Cubit/cubit.dart';
import 'package:movies_app/view_models/Auth_Cubit/states.dart';
import 'package:movies_app/views/auth_views/forgot_password_view.dart';
import 'package:movies_app/views/auth_views/signup_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/widgets/custom_button.dart';
import 'package:movies_app/widgets/custom_textformfield.dart';

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Stack(
                children: [
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3), BlendMode.darken),
                    child: Image.asset(
                      'assets/images/signin.jpeg',
                      width: double.infinity,
                      height: height(406),
                      fit: BoxFit.cover,
                      colorBlendMode: BlendMode.dstATop,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width(16), vertical: height(220)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: LocaleKeys.welcome_back.tr(),
                          fontsize: 30.sp,
                          color: Colors.white,
                          height: 2,
                          fontWeight: FontWeight.w600,
                        ),
                        CustomText(
                          text: LocaleKeys.signin_now.tr(),
                          fontsize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          height: 1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: height(360)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                padding: EdgeInsets.symmetric(
                  horizontal: width(16),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                  color: Colors.white,
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height(24),
                        ),
                        CustomFormField(
                          context: context,
                          controller: _emailEditingController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "";
                            }
                            return null;
                          },
                          label: LocaleKeys.email.tr(),
                          hintText: "support.kw@foxpes.com",
                        ),
                        SizedBox(
                          height: height(16),
                        ),
                        CustomFormField(
                          context: context,
                          controller: _passwordEditingController,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return " ";
                            }
                            return null;
                          },
                          label: LocaleKeys.password.tr(),
                          suffix: IconButton(
                            icon: SvgPicture.asset(cubit.suffix),
                            onPressed: () {
                              cubit.changePasswordVisibility();
                            },
                          ),
                          isPassword: cubit.isPassword,
                          hintText: "*************",
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: () {
                              navigateTo(context, ForgotPasswordView());
                            },
                            child: Text(
                              LocaleKeys.forgetPassword.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: kPrimaryColor,
                                    fontSize: 13.sp,
                                    height: 1,
                                  ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height(10),
                        ),
                        ConditionalBuilder(
                          condition: state is! LogInLoadingState,
                          builder: (context) => CustomButton(
                            radius: 6,
                            function: () {
                              if (_formKey.currentState!.validate()) {
                                cubit.signIn(
                                  email: _emailEditingController.text,
                                  password: _passwordEditingController.text,
                                  context: context,
                                );
                              }
                            },
                            text: LocaleKeys.login.tr(),
                            isUpperCase: true,
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        ),
                        SizedBox(
                          height: height(122),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              LocaleKeys.doNotHave.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                            TextButton(
                                onPressed: () async {
                                  
                                  navigateTo(context, RegisterView());
                                },
                                child: Text(
                                  LocaleKeys.register.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: kPrimaryColor,
                                      ),
                                )),
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
