import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/translations/locale_keys.g.dart';
import 'package:movies_app/view_models/Client_cubit/cubit.dart';
import 'package:movies_app/view_models/Client_cubit/states.dart';
import 'package:movies_app/widgets/custom_button.dart';
import 'package:movies_app/widgets/custom_profile_textField.dart';
import 'package:movies_app/widgets/custom_text.dart';

class ClientProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var _formKey = GlobalKey<FormState>();
    TextEditingController _emailEditingController = TextEditingController();
    TextEditingController _firstNameEditingController = TextEditingController();
    TextEditingController _lastNameEditingController = TextEditingController();
    TextEditingController _phoneEditingController = TextEditingController();
    TextEditingController _birthDateEditingController = TextEditingController();
    TextEditingController _experienceEditingController = TextEditingController();
    TextEditingController _priceEditingController = TextEditingController();
    TextEditingController _durationEditingController = TextEditingController();
    TextEditingController _bioEditingController = TextEditingController();
    TextEditingController _skillsEditingController = TextEditingController();
    TextEditingController _teachInEditingController = TextEditingController();
    TextEditingController _religionEditingController = TextEditingController();
    TextEditingController _degreeEditingController = TextEditingController();
    TextEditingController _statusEditingController = TextEditingController();
    TextEditingController _speakEditingController = TextEditingController();
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          constraints: BoxConstraints(),
          padding: EdgeInsets.zero,
          icon: SvgPicture.asset(
            "assets/icons/arrow-right.svg",
          ),
        ),
        title: CustomText(
          text: LocaleKeys.profile.tr(),
          fontsize: 18.sp,
          color: kSecondaryColor,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<ClientCubit, ClientStates>(
        builder: (context, state) {
          ClientCubit cubit = ClientCubit.get(context);
          _firstNameEditingController.text = cubit.logInModel!.firstName!;
          _lastNameEditingController.text = cubit.logInModel!.lastName!;
          _emailEditingController.text = cubit.logInModel!.email!;
          _phoneEditingController.text = cubit.logInModel!.phone!;
          if (cubit.logInModel!.category != "Student") {
            _birthDateEditingController.text = cubit.logInModel!.birthDate!;
            _experienceEditingController.text = cubit.logInModel!.experience!;
            _priceEditingController.text = cubit.logInModel!.price!;
            _durationEditingController.text = cubit.logInModel!.duration!;
            _bioEditingController.text = cubit.logInModel!.aboutYou!;
            if (cubit.logInModel!.category == "Teacher") {
              _skillsEditingController.text = cubit.logInModel!.skills!;
              _teachInEditingController.text = cubit.logInModel!.teachIn!;
            } else if (cubit.logInModel!.category == "Baby Sitter") {
              _religionEditingController.text = cubit.logInModel!.religion!;
              _degreeEditingController.text = cubit.logInModel!.degree!;
              _speakEditingController.text = cubit.logInModel!.speaks!;
              _statusEditingController.text = cubit.logInModel!.status!;
            }
          }
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width(16),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height(15),
                    ),
                    Center(
                      child: SizedBox(
                        height: height(115),
                        child: Stack(
                          children: [
                            CircleAvatar(
                                radius: width(35.5),
                                backgroundColor: Colors.white,
                                backgroundImage: cubit.personalImage == null
                                    ? NetworkImage(
                                        cubit.logInModel!.image!,
                                      )
                                    : FileImage(cubit.personalImage!)
                                        as ImageProvider),
                            Positioned(
                              top: height(65),
                              left: width(40),
                              child: Container(
                                  width: width(29),
                                  height: height(29),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFF2F2FF),
                                  ),
                                  child: IconButton(
                                      onPressed: () {
                                        cubit.chooseImagre(key: "other");
                                      },
                                      icon: SvgPicture.asset(
                                        "assets/icons/choose-image.svg",
                                      ))),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (state is GetUriUpdateProfileLoadingState)
                      Column(
                        children: [
                          LinearProgressIndicator(
                            color: kPrimaryColor,
                          ),
                          SizedBox(
                            height: height(10),
                          ),
                        ],
                      ),
                    Center(
                      child: CustomText(
                        text:
                            "${cubit.logInModel!.firstName} ${cubit.logInModel!.lastName}",
                        fontsize: 17.sp,
                        color: kSecondaryColor,
                        height: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Center(
                      child: CustomText(
                          text: cubit.logInModel!.email,
                          fontsize: 11.sp,
                          height: 1,
                          color: kPrimaryColor),
                    ),
                    SizedBox(
                      height: height(34),
                    ),
                    CustomText(
                        text: LocaleKeys.personalInfo.tr(),
                        fontsize: 15.sp,
                        color: kSecondaryColor),
                    SizedBox(
                      height: height(15),
                    ),
                    FirstProfileFields(
                      firstNameEditingController: _firstNameEditingController,
                      lastNameEditingController: _lastNameEditingController,
                      emailEditingController: _emailEditingController,
                      phoneEditingController: _phoneEditingController,
                    ),
                    if (cubit.logInModel!.category != "Student")
                      SecondProfileFields(
                          birthDateEditingController:
                              _birthDateEditingController,
                          experienceEditingController:
                              _experienceEditingController),
                    if (cubit.logInModel!.category == "Teacher")
                      TeacherProfileFields(
                          skillsEditingController: _skillsEditingController,
                          teachInEditingController: _teachInEditingController),
                    if (cubit.logInModel!.category == "Baby Sitter")
                      BabySitterProfileFields(
                          religionEditingController: _religionEditingController,
                          statusEditingController: _statusEditingController,
                          degreeEditingController: _degreeEditingController,
                          speakEditingController: _speakEditingController),
                    if (cubit.logInModel!.category != "Student")
                      PaymentProfileFields(
                          priceEditingController: _priceEditingController,
                          durationEditingController: _durationEditingController,
                          bioEditingController: _bioEditingController),
                    SizedBox(
                      height: height(
                          cubit.logInModel!.category == "Student" ? 176 : 16),
                    ),
                    ConditionalBuilder(
                      condition: state is! UpdateProfileLoadingState,
                      builder: (context) => CustomButton(
                          isUpperCase: true,
                          function: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.updateUser(
                                  logInModel: LogInModel(
                                email: _emailEditingController.text,
                                phone: _phoneEditingController.text,
                                firstName: _firstNameEditingController.text,
                                lastName: _lastNameEditingController.text,
                                uid: cubit.logInModel!.uid,
                                image: cubit.personalImageUri != null
                                    ? cubit.personalImageUri
                                    : cubit.logInModel!.image,
                                token: tokenMessages,
                                gender: cubit.logInModel!.gender,
                                category: cubit.logInModel!.category,
                                password: cubit.logInModel!.password,
                                price: _priceEditingController.text,
                                duration: _durationEditingController.text,
                                aboutYou: _bioEditingController.text,
                                birthDate: _birthDateEditingController.text,
                                country: cubit.logInModel!.country,
                                experience: _experienceEditingController.text,
                                careType: cubit.logInModel!.careType,
                                carNumber: cubit.logInModel!.carNumber,
                                idCardImage: cubit.logInModel!.idCardImage,
                                carImages: cubit.logInModel!.carImages,
                                licienceCardImage:
                                    cubit.logInModel!.licienceCardImage,
                                carPlateImage: cubit.logInModel!.carPlateImage,
                                skills: _skillsEditingController.text,
                                faculty: cubit.logInModel!.faculty,
                                teachIn: _teachInEditingController.text,
                                religion: _religionEditingController.text,
                                status: _statusEditingController.text,
                                degree: _degreeEditingController.text,
                                speaks: _speakEditingController.text,
                              ));
                            }
                          },
                          text: LocaleKeys.save.tr()),
                      fallback: (context) => Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ),
                    SizedBox(
                      height: height(15),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}

class FirstProfileFields extends StatelessWidget {
  final TextEditingController emailEditingController;
  final TextEditingController firstNameEditingController;
  final TextEditingController lastNameEditingController;
  final TextEditingController phoneEditingController;

  FirstProfileFields({
    required this.firstNameEditingController,
    required this.lastNameEditingController,
    required this.emailEditingController,
    required this.phoneEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileFormField(
          controller: firstNameEditingController,
          label: "${LocaleKeys.name.tr()}:",
          validate: (value) {
            if (value!.isEmpty) {
              return "";
            }
            return null;
          },
        ),
        SizedBox(
          height: height(16),
        ),
        ProfileFormField(
          controller: lastNameEditingController,
          label: "${LocaleKeys.lastName.tr()}:",
          validate: (value) {
            if (value!.isEmpty) {
              return "";
            }
            return null;
          },
        ),
        SizedBox(
          height: height(16),
        ),
        ProfileFormField(
          controller: emailEditingController,
          label: "${LocaleKeys.email.tr()}:",
          validate: (value) {
            if (value!.isEmpty) {
              return "";
            }
            return null;
          },
        ),
        SizedBox(
          height: height(16),
        ),
        ProfileFormField(
          controller: phoneEditingController,
          label: "${LocaleKeys.phoneNumber.tr()}:",
          validate: (value) {
            if (value!.isEmpty) {
              return "";
            }
            return null;
          },
        ),
      ],
    );
  }
}

class SecondProfileFields extends StatelessWidget {
  final TextEditingController birthDateEditingController;
  final TextEditingController experienceEditingController;

  SecondProfileFields({
    required this.birthDateEditingController,
    required this.experienceEditingController,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height(16),
        ),
        ProfileFormField(
          controller: birthDateEditingController,
          label: "${LocaleKeys.birthdate.tr()}:",
          validate: (value) {
            if (value!.isEmpty) {
              return "";
            }
            return null;
          },
        ),
        SizedBox(
          height: height(16),
        ),
        ProfileFormField(
          controller: experienceEditingController,
          label: "${LocaleKeys.experience.tr()}:",
          validate: (value) {
            if (value!.isEmpty) {
              return "";
            }
            return null;
          },
        ),
      ],
    );
  }
}

class PaymentProfileFields extends StatelessWidget {
  final TextEditingController priceEditingController;
  final TextEditingController durationEditingController;
  final TextEditingController bioEditingController;

  PaymentProfileFields({
    required this.priceEditingController,
    required this.durationEditingController,
    required this.bioEditingController,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height(16),
        ),
        CustomText(
            text: LocaleKeys.paymentInfo.tr(), fontsize: 15.sp, color: kSecondaryColor),
        SizedBox(
          height: height(15),
        ),
        ProfileFormField(
          controller: priceEditingController,
          label: "${LocaleKeys.price.tr()}:",
          validate: (value) {
            if (value!.isEmpty) {
              return "";
            }
            return null;
          },
        ),
        SizedBox(
          height: height(16),
        ),
        ProfileFormField(
          controller: durationEditingController,
          label: "${LocaleKeys.duration.tr()}",
          validate: (value) {
            if (value!.isEmpty) {
              return "";
            }
            return null;
          },
        ),
        SizedBox(
          height: height(16),
        ),
        CustomText(text: LocaleKeys.bio.tr(), fontsize: 15.sp, color: kSecondaryColor),
        SizedBox(
          height: height(15),
        ),
        Container(
          width: double.infinity,
          height: height(148),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), //color of shadow
                spreadRadius: 0.1, //spread radius
                blurRadius: 5, // blur radius
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Container(
            width: width(206),
            child: TextFormField(
              controller: bioEditingController,
              maxLines: 10,
              validator: (value) {
                if (value!.isEmpty) {
                  return "";
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                errorStyle: TextStyle(
                  height: 0,
                ),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: width(16), vertical: height(10)),
                counterText: "",
                alignLabelWithHint: false,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(6)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(6)),
              ),
              style: TextStyle(
                  fontSize: 13.sp,
                  color: kHintTextColor,
                  fontWeight: FontWeight.normal),
            ),
          ),
        )
      ],
    );
  }
}

class TeacherProfileFields extends StatelessWidget {
  final TextEditingController skillsEditingController;
  final TextEditingController teachInEditingController;

  TeacherProfileFields({
    required this.skillsEditingController,
    required this.teachInEditingController,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height(16),
        ),
        ProfileFormField(
          controller: skillsEditingController,
          label: "${LocaleKeys.skills.tr()}:",
          validate: (value) {
            if (value!.isEmpty) {
              return "";
            }
            return null;
          },
        ),
        SizedBox(
          height: height(16),
        ),
        ProfileFormField(
          controller: teachInEditingController,
          label: "${LocaleKeys.teachIn.tr()}:",
          validate: (value) {
            if (value!.isEmpty) {
              return "";
            }
            return null;
          },
        ),
      ],
    );
  }
}

class BabySitterProfileFields extends StatelessWidget {
  final TextEditingController religionEditingController;
  final TextEditingController statusEditingController;
  final TextEditingController degreeEditingController;
  final TextEditingController speakEditingController;

  BabySitterProfileFields({
    required this.religionEditingController,
    required this.statusEditingController,
    required this.degreeEditingController,
    required this.speakEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height(16),
        ),
        ProfileFormField(
          controller: religionEditingController,
          label: "${LocaleKeys.religion.tr()}:",
          validate: (value) {
            if (value!.isEmpty) {
              return "";
            }
            return null;
          },
        ),
        SizedBox(
          height: height(16),
        ),
        ProfileFormField(
          controller: statusEditingController,
          label: "${LocaleKeys.status.tr()}:",
          validate: (value) {
            if (value!.isEmpty) {
              return "";
            }
            return null;
          },
        ),
        SizedBox(
          height: height(16),
        ),
        ProfileFormField(
          controller: degreeEditingController,
          label: "${LocaleKeys.degree.tr()}:",
          validate: (value) {
            if (value!.isEmpty) {
              return "";
            }
            return null;
          },
        ),
        SizedBox(
          height: height(16),
        ),
        ProfileFormField(
          controller: speakEditingController,
          label: "${LocaleKeys.speaking.tr()}:",
          validate: (value) {
            if (value!.isEmpty) {
              return "";
            }
            return null;
          },
        ),
        SizedBox(
          height: height(16),
        ),
      ],
    );
  }
}
