import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/translations/locale_keys.g.dart';
import 'package:movies_app/view_models/Auth_Cubit/cubit.dart';
import 'package:movies_app/view_models/Auth_Cubit/states.dart';
import 'package:movies_app/views/auth_views/otp_verfication_view.dart';
import 'package:movies_app/widgets/custom_button.dart';
import 'package:movies_app/widgets/custom_datepicker.dart';
import 'package:movies_app/widgets/custom_dropdown.dart';
import 'package:movies_app/widgets/custom_navigation.dart';
import 'package:movies_app/widgets/custom_textformfield.dart';

class BabySitterSignUpView extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phone;
  final String category;
  final String gender;
    final TextEditingController _priceController = TextEditingController();
  final TextEditingController _aboutMeController = TextEditingController();

  BabySitterSignUpView({required this.firstName, required this.lastName, required this.email, required this.password, required this.phone, required this.gender, required this.category});

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
        List<String> durationTr = [
    LocaleKeys.perHour.tr(),
    LocaleKeys.perDay.tr(),
    LocaleKeys.perWeek.tr(),
    LocaleKeys.perMonth.tr(),
];
List<String> statusTr = [
  LocaleKeys.single.tr(),
  LocaleKeys.taken.tr(),
];
List<String> educationTr = [
  LocaleKeys.bachelorDegree.tr(),
  LocaleKeys.highSchool.tr(),
  LocaleKeys.notEducated.tr(),
];
List<String> experienceTr = [
  "2 ${LocaleKeys.years.tr()}",
  "4 ${LocaleKeys.years.tr()}",
  "6 ${LocaleKeys.years.tr()}",
  "8 ${LocaleKeys.years.tr()}",
  "10 ${LocaleKeys.years.tr()}",
  "+10 ${LocaleKeys.years.tr()}",
];
List<String> religionTr = [
  LocaleKeys.muslim.tr(),
  LocaleKeys.cristian.tr(),
  LocaleKeys.other.tr(),
];
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, states) {},
        builder: (context, states) {
          AuthCubit cubit = AuthCubit();
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width(16)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height(20),
                      ),
                      CustomDatePicker(
                        onChange: (value) {
                          // TODO: choose birth date
                          cubit.choosebirthDate(value!);
                          print(cubit.birthDate);
                        },
                        validate: (value) {
                            if (value!.isEmpty) {
                              return "";
                            } else {
                              return null;
                            }
                          },
                      ),
                      SizedBox(
                        height: height(24),
                      ),
                      CustomDropDownBox(
                          context: context,
                          hint: "2 ${LocaleKeys.years}",
                          dropItems: List.generate(experience.length, (index) {
                            return DropdownMenuItem<String>(
                              child: Text(
                                experienceTr[index],
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              value: experience[index],
                            );
                          }),
                          label: LocaleKeys.experience.tr(),
                          onChange: (value) {
                            cubit.chooseExperience(value!);
                          },
                          validate: (value) {
                            if (value == null) {
                              return "";
                            } else {
                              return null;
                            }
                          }),
                      SizedBox(
                        height: height(24),
                      ),
                      CustomDropDownBox(
                          context: context,
                          hint: "Egypt",
                          dropItems: List.generate(countries.length, (index) {
                            return DropdownMenuItem<String>(
                              child: Text(
                                countries[index].name!,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              value: countries[index].name!,
                            );
                          }),
                          label: LocaleKeys.country.tr(),
                          onChange: (value) {
                            cubit.chooseCountry(value!);
                          },
                          validate: (value) {
                            if (value == null) {
                              return "";
                            } else {
                              return null;
                            }
                          }),
                      SizedBox(
                        height: height(24),
                      ),
                      CustomDropDownBox(
                          context: context,
                          hint: religionTr[0],
                          dropItems: List.generate(religion.length, (index) {
                            return DropdownMenuItem<String>(
                              child: Text(
                                religionTr[index],
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              value: religion[index],
                            );
                          }),
                          label: LocaleKeys.religion.tr(),
                          onChange: (value) {
                            cubit.choosereligion(value!);
                            
                          },
                          validate: (value) {
                            if (value == null) {
                              return "";
                            } else {
                              return null;
                            }
                          }),
                      SizedBox(
                        height: height(24),
                      ),
                      CustomDropDownBox(
                          context: context,
                          hint: statusTr[0],
                          dropItems: List.generate(status.length, (index) {
                            return DropdownMenuItem<String>(
                              child: Text(
                                statusTr[index],
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              value: status[index],
                            );
                          }),
                          label: LocaleKeys.status.tr(),
                          onChange: (value) {
                            cubit.choosestatus(value!);
                          },
                          validate: (value) {
                            if (value == null) {
                              return "";
                            } else {
                              return null;
                            }
                          }),
                      SizedBox(
                        height: height(24),
                      ),
                      CustomDropDownBox(
                          context: context,
                          hint: educationTr[0],
                          dropItems: List.generate(education.length, (index) {
                            return DropdownMenuItem<String>(
                              child: Text(
                                educationTr[index],
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              value: education[index],
                            );
                          }),
                          label: LocaleKeys.education.tr(),
                          onChange: (value) {
                            cubit.choosedegree(value!);
                          },
                          validate: (value) {
                            if (value == null) {
                              return "";
                            } else {
                              return null;
                            }
                          }),
                      SizedBox(
                        height: height(24),
                      ),
                      CustomDropDownBox(
                          context: context,
                          hint: "English",
                          dropItems: List.generate(language.length, (index) {
                            return DropdownMenuItem<String>(
                              child: Text(
                                language[index],
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              value: language[index],
                            );
                          }),
                          label: LocaleKeys.language.tr(),
                          onChange: (value) {
                            cubit.choosespeak(value!);
                          },
                          validate: (value) {
                            if (value == null) {
                              return "";
                            } else {
                              return null;
                            }
                          }),
                      SizedBox(
                        height: height(24),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: CustomFormField(
                            context: context,
                            controller: _priceController,
                            type: TextInputType.number,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "";
                              }
                              return null;
                            },
                            label: LocaleKeys.price.tr(),
                            hintText: "300 KWD",
                          )),
                          SizedBox(
                            width: width(9),
                          ),
                          Expanded(
                              child: CustomDropDownBox(
                            context: context,
                            dropItems: List.generate(
                                duration.length,
                                (index) => DropdownMenuItem<String>(
                                      child: Text(
                                        durationTr[index],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                      value: duration[index],
                                    )),
                            validate: (value) {
                              if (value == null) {
                                return "";
                              }
                              return null;
                            },
                            label: LocaleKeys.duration.tr(),
                            hint: LocaleKeys.perHour.tr(),
                            onChange: (value) {
                              cubit.chooseduration(value!);
                            },
                          )),
                        ],
                      ),
                      SizedBox(
                        height: height(24),
                      ),
                      CustomFormField(
                        context: context,
                        maxLines: 6,
                        isAboutMe: true,
                        controller: _aboutMeController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "";
                          }
                          return null;
                        },
                        label: LocaleKeys.aboutYou.tr(),
                        hintText: LocaleKeys.writeSomething.tr(),
                      ),
                      SizedBox(
                        height: height(24),
                      ),
                      CustomButton(
                          isUpperCase: true, function: () {
                            if (_formKey.currentState!.validate()) {
                              navigateTo(
                                  context,
                                  OtpVerficationView(
                                      logInModel: LogInModel(
                                    firstName: firstName,
                                    lastName: lastName,
                                    email: email,
                                    password: password,
                                    phone: phone,
                                    gender: gender,
                                    category: category,
                                    birthDate: cubit.birthDate,
                                    country: cubit.country,
                                    experience: cubit.experience,
                                    religion: cubit.religion,
                                    status: cubit.status,
                                    degree: cubit.degree,
                                    speaks: cubit.speak,
                                    price: _priceController.text,
                                    duration: cubit.duration,
                                    aboutYou: _aboutMeController.text,
                                  )));
                            }
                          }, text: LocaleKeys.confirm.tr()),
                      SizedBox(
                        height: height(16),
                      ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}
