import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/translations/locale_keys.g.dart';
import 'package:movies_app/view_models/Auth_Cubit/cubit.dart';
import 'package:movies_app/view_models/Auth_Cubit/states.dart';
import 'package:movies_app/widgets/custom_button.dart';
import 'package:movies_app/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/widgets/custom_textformfield.dart';

class ForgotPasswordView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailEditingController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.forgetPassword.tr(),
              style: Theme.of(context).textTheme.subtitle1),
        ),
        body: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {},
          builder: (context, state) {
            AuthCubit cubit = AuthCubit.get(context);
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width(16)),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height(64),
                      ),
                      Image.asset(
                        "assets/images/resend.png",
                        width: width(165),
                        height: height(152),
                      ),
                      SizedBox(
                        height: height(25),
                      ),
                      CustomText(
                        text: LocaleKeys.forgetYourPassword.tr(),
                        fontsize: 18.sp,
                        textAlign: TextAlign.center,
                        height: 1,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: height(16),
                      ),
                      CustomText(
                        text:
                            "${LocaleKeys.forgetPasswrod1.tr()} ${LocaleKeys.forgetPassword2.tr()}",
                        fontsize: 13.sp,
                        textAlign: TextAlign.center,
                        height: 1.5,
                        maxLines: 3,
                        color: Color(0xFF707070),
                      ),
                      SizedBox(
                        height: height(63),
                      ),
                      Form(
                        key: _formKey,
                        child: CustomFormField(
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
                          hintText: "support.kw@gmail.com",
                        ),
                      ),
                      SizedBox(
                        height: height(24),
                      ),
                      ConditionalBuilder(
                        condition: state is! ResetPasswordLoadingState,
                        builder: (context) => CustomButton(
                            radius: 6.0,
                            isUpperCase: true,
                            function: () {
                              // TODO: reset password function
                              if (_formKey.currentState!.validate()) {
                                cubit.resetPassword(
                                    email: _emailEditingController.text,
                                    context: context);
                              }
                            },
                            text: LocaleKeys.sendCode.tr()),
                        fallback: (context) => Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
