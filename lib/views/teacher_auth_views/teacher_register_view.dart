// ignore: import_of_legacy_library_into_null_safe
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/services/helper/icon_broken.dart';
import 'package:movies_app/services/local/cache_helper.dart';
import 'package:movies_app/translate/locale_keys.g.dart';
import 'package:movies_app/view_models/App_Cubit/cubit.dart';
import 'package:movies_app/view_models/Auth_Cubit/cubit.dart';
import 'package:movies_app/view_models/Auth_Cubit/states.dart';
import 'package:movies_app/views/auth_views/otp_verfication_view.dart';
import 'package:movies_app/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sizer/sizer.dart';


class TeacherRegisterView extends StatefulWidget {
  @override
  _TeacherRegisterViewState createState() => _TeacherRegisterViewState();
}

class _TeacherRegisterViewState extends State<TeacherRegisterView> {

  var _formKey = GlobalKey<FormState>();
  Object? field;
  Object? gender;
  TextEditingController _emailEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _phoneEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.applyHead.tr(), style: Theme.of(context).textTheme.bodyText1!.copyWith(
          color: Colors.black,
          fontSize: 14.sp,
        ),),
        centerTitle: true,
        leading: IconButton(icon: Icon(IconBroken.Arrow___Left_2, color: Colors.red,), onPressed: () {Navigator.pop(context);},),
      ),
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if(state is CreateTeacherSuccessState) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.teacherModel!.uid,
            ).then((value)
            {
              CacheHelper.saveData(key: "categorie", value: "teacher").then((value) {
                if(value)
                  AppCubit.get(context).getCacheData();
                  navigateToAndFinish(
                    context,
                    OTPView(_phoneEditingController.text, "teacher"),
                );
              });
            });
            showToast(text: "Apply Success", state: ToastState.SUCCESS);
          }
          else if(state is TeacherSignUpErrorState){
            showToast(text: state.error, state: ToastState.ERROR);
          }
        },
        builder: (context, state) {

          AuthCubit cubit = AuthCubit.get(context);

          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 1.h,),
                    Center(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 40.0,
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blueGrey,
                            backgroundImage: cubit.profileImage == null ? NetworkImage('https://image.freepik.com/free-photo/bearded-young-self-confident-male-with-pleasant-appearance-dressed-blue-shirt-looks-directly-isolated-white-wall-handsome-man-freelancer-thinks-about-work-indoor_273609-16089.jpg') : FileImage(cubit.profileImage!) as ImageProvider,),
                          CircleAvatar(
                              radius: 15.0,
                              foregroundColor: Colors.white,
                              backgroundColor: kPrimaryColor,
                              child: IconButton(
                                icon: Icon(IconBroken.Camera, size: 10.0,),
                                onPressed: () {
                                  cubit.getProfileImage();
                                },
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    defaultFormField(
                        context: context,
                        controller: _nameEditingController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your Name";
                          }
                          return null;
                        },
                        label: LocaleKeys.Name.tr(),
                        prefix: IconBroken.Profile),
                    SizedBox(
                      height: 3.h,
                    ),
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
                        prefix: IconBroken.User),
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
                      height: 3.h,
                    ),
                    defaultFormField(
                      context: context,
                      controller: _phoneEditingController,
                      maxLength: 8,
                      type: TextInputType.phone,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Your Phone Number";
                        }
                        return null;
                      },
                      label: LocaleKeys.phoneNumber.tr(),
                      prefix: IconBroken.Call,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(items: fields.map(buildMenuItem).toList(),
                              value: field,
                              hint: Text(LocaleKeys.chooseField.tr(), style: Theme.of(context).textTheme.bodyText2,),
                              onChanged: (value) => setState(() => field = value),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        Container(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(items: genders.map(buildMenuItem).toList(),
                              value: gender,
                              hint: Text(LocaleKeys.chooseGender.tr(), style: Theme.of(context).textTheme.bodyText2,),
                              onChanged: (value) => setState(() => gender = value),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    ConditionalBuilder(
                      condition: state is! TeacherSignUpLoadingState && state is! TeacherUploadLoadingState && state is! CreateTeacherLoadingState,
                      builder: (context) => defaultButton(function: (){
                        if (_formKey.currentState!.validate()) {
                          if(field != null && gender != null) {
                            cubit.teacherSignUp(
                              name: _nameEditingController.text,
                              phone: _phoneEditingController.text,
                              email: _emailEditingController.text,
                              field: field,
                              gender: gender,
                              password: _passwordEditingController.text,
                            );
                          }else {
                            showToast(text: "Please complete the form", state: ToastState.ERROR);
                          }
                        }
                      }, text: LocaleKeys.apply.tr(), radius: 25.0,),
                      fallback: (context) => Center(child: CircularProgressIndicator(),),
                    ),
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


