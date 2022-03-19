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

class TeacherSignUpView extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phone;
  final String category;
  final String gender;
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _aboutMeController = TextEditingController();

  TeacherSignUpView(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.phone,
      required this.gender,
      required this.category});

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    List<String> durationTr = [
      LocaleKeys.perHour.tr(),
      LocaleKeys.perDay.tr(),
      LocaleKeys.perWeek.tr(),
      LocaleKeys.perMonth.tr(),
    ];
    List<String> experienceTr = [
      "2 ${LocaleKeys.years.tr()}",
      "4 ${LocaleKeys.years.tr()}",
      "6 ${LocaleKeys.years.tr()}",
      "8 ${LocaleKeys.years.tr()}",
      "10 ${LocaleKeys.years.tr()}",
      "+10 ${LocaleKeys.years.tr()}",
    ];
    List<String> skillsTr = [
      LocaleKeys.grammer.tr(),
      LocaleKeys.speaking.tr(),
      LocaleKeys.listening.tr(),
    ];
    List<String> facultiesTr = [
      LocaleKeys.computerScience.tr(),
      LocaleKeys.engineering.tr(),
      LocaleKeys.law.tr(),
      LocaleKeys.art.tr(),
      LocaleKeys.buissniss.tr(),
      LocaleKeys.pharmacy.tr(),
      LocaleKeys.medecine.tr(),
      LocaleKeys.dentistry.tr(),
      LocaleKeys.other.tr(),
    ];
    List<String> subjectsTr = [
      LocaleKeys.arabic.tr(),
      LocaleKeys.art.tr(),
      LocaleKeys.biology.tr(),
      LocaleKeys.chemistry.tr(),
      LocaleKeys.english.tr(),
      LocaleKeys.french.tr(),
      LocaleKeys.general.tr(),
      LocaleKeys.geology.tr(),
      LocaleKeys.german.tr(),
      LocaleKeys.history.tr(),
      LocaleKeys.italian.tr(),
      LocaleKeys.math.tr(),
      LocaleKeys.philosophy.tr(),
      LocaleKeys.physics.tr(),
      LocaleKeys.programming.tr(),
      LocaleKeys.quran.tr(),
      LocaleKeys.religion.tr(),
      LocaleKeys.science.tr(),
      LocaleKeys.spanish.tr(),
      LocaleKeys.socialStudies.tr(),
      LocaleKeys.descriptiveSignLanguage.tr(),
      LocaleKeys.speech_and_language_therapy.tr(),
      LocaleKeys.turkey.tr(),
      LocaleKeys.economics.tr(),
      LocaleKeys.accounting.tr(),
      LocaleKeys.engineering.tr(),
      LocaleKeys.law.tr(),
      LocaleKeys.statistics.tr(),
      LocaleKeys.geoghraphy.tr(),
    ];
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
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
                          hint: "2 ${LocaleKeys.years.tr()}",
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
                          hint: LocaleKeys.grammar_speaking_listening.tr(),
                          dropItems: List.generate(
                              skills.length,
                              (index) => DropdownMenuItem<String>(
                                    child: Text(
                                      skillsTr[index],
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    value: skills[index],
                                  )),
                          label: LocaleKeys.skills.tr(),
                          onChange: (value) {
                            cubit.chooseskills(value!);
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
                          hint: LocaleKeys.computerScience.tr(),
                          dropItems: List.generate(
                              faculties.length,
                              (index) => DropdownMenuItem<String>(
                                    child: Text(
                                      facultiesTr[index],
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    value: faculties[index],
                                  )),
                          label: LocaleKeys.faculty.tr(),
                          onChange: (value) {
                            cubit.choosefaculty(value!);
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
                          hint: subjectsTr[0],
                          dropItems: List.generate(
                              subjects.length,
                              (index) => DropdownMenuItem<String>(
                                    child: Text(
                                      subjectsTr[index],
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    value: subjects[index],
                                  )),
                          label: LocaleKeys.teachIn.tr(),
                          onChange: (value) {
                            cubit.choosesubject(value!);
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
                          isUpperCase: true,
                          function: () {
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
                                    skills: cubit.skills,
                                    faculty: cubit.faculty,
                                    teachIn: cubit.subject,
                                    price: _priceController.text,
                                    duration: cubit.duration,
                                    aboutYou: _aboutMeController.text,
                                  )));
                            }
                          },
                          text: LocaleKeys.confirm.tr()),
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
