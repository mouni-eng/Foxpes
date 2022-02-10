import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/services/local/cache_helper.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/translate/locale_keys.g.dart';
import 'package:movies_app/view_models/Auth_Cubit/cubit.dart';
import 'package:movies_app/view_models/Auth_Cubit/states.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:movies_app/views/auth_views/otp_verfication_view.dart';
import 'package:movies_app/widgets/custom_button.dart';
import 'package:movies_app/widgets/custom_dropdown.dart';
import 'package:movies_app/widgets/custom_navigation.dart';
import 'package:movies_app/widgets/custom_textformfield.dart';
import 'package:movies_app/widgets/custom_toast.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    TextEditingController _emailEditingController = TextEditingController();
    TextEditingController _passwordEditingController = TextEditingController();
    TextEditingController _firstNameEditingController = TextEditingController();
    TextEditingController _lastNameEditingController = TextEditingController();
    TextEditingController _phoneEditingController = TextEditingController();
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width(16)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height(35),
                      ),
                      Text(
                        LocaleKeys.registerHeading.tr(),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: height(32),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomFormField(
                                context: context,
                                controller: _firstNameEditingController,
                                type: TextInputType.text,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return "";
                                  }
                                  return null;
                                },
                                label: LocaleKeys.Name.tr(),
                                hintText: "Mohamed"),
                          ),
                          SizedBox(
                            width: width(9),
                          ),
                          Expanded(
                            child: CustomFormField(
                              context: context,
                              controller: _lastNameEditingController,
                              type: TextInputType.text,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "";
                                }
                                return null;
                              },
                              label: LocaleKeys.lastName.tr(),
                              hintText: "Mounir",
                            ),
                          ),
                        ],
                      ),
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
                          hintText: "support.kw@gmail.com"),
                      SizedBox(
                        height: height(24),
                      ),
                      CustomFormField(
                        context: context,
                        controller: _passwordEditingController,
                        type: TextInputType.visiblePassword,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "";
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
                      SizedBox(
                        height: height(24),
                      ),
                      CustomDropDownBox(
                          validate: (value) {
                            if (value == null) {
                              return "";
                            }
                            return null;
                          },
                          context: context,
                          dropItems: [
                            DropdownMenuItem<String>(
                              child: Text(
                                "Student",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              value: "Student",
                            ),
                            DropdownMenuItem<String>(
                              child: Text(
                                "Teacher",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              value: "Teacher",
                            ),
                            DropdownMenuItem<String>(
                              child: Text(
                                "Baby Sitter",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              value: "Baby Sitter",
                            ),
                            DropdownMenuItem<String>(
                              child: Text(
                                "Driver",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              value: "Driver",
                            ),
                          ],
                          label: LocaleKeys.registerAS.tr(),
                          hint: "Choose Category",
                          onChange: (String? value) {
                            cubit.chooseCategories(value!);
                          }),
                      SizedBox(
                        height: height(24),
                      ),
                      CustomDropDownBox(
                          validate: (value) {
                            if (value == null) {
                              return "";
                            }
                            return null;
                          },
                          context: context,
                          dropItems: [
                            DropdownMenuItem<String>(
                              child: Text(
                                "Male",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              value: "Student",
                            ),
                            DropdownMenuItem<String>(
                              child: Text(
                                "Female",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              value: "Teacher",
                            ),
                          ],
                          label: "Gender",
                          hint: "Choose Gender",
                          onChange: (String? value) {
                            cubit.chooseGender(value!);
                          }),
                      SizedBox(
                        height: height(24),
                      ),
                      CustomFormField(
                        context: context,
                        controller: _phoneEditingController,
                        type: TextInputType.phone,
                        maxLength: 11,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "";
                          }
                          return null;
                        },
                        label: LocaleKeys.phoneNumber.tr(),
                        hintText: "(+965) 53 5266 516",
                        suffix: Image.asset("assets/icons/kuwait.png",
                            width: width(24), height: height(13)),
                      ),
                      SizedBox(
                        height: height(54),
                      ),
                       CustomButton(
                          function: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.nextSignUpScreen(
                                  context: context, logInModel: LogInModel());
                            }
                          },
                          text: LocaleKeys.register.tr(),
                          isUpperCase: true,
                          radius: 6.0,
                        ),
                      SizedBox(
                        height: height(70),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Sign In",
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
          );
        },
      ),
    );
  }
}
