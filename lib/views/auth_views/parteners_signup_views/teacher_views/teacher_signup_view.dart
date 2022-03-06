import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/size_config.dart';
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
                      ),
                      SizedBox(
                        height: height(24),
                      ),
                      CustomDropDownBox(
                          context: context,
                          hint: "2 years",
                          dropItems: List.generate(experience.length, (index) {
                            return DropdownMenuItem<String>(
                              child: Text(
                                experience[index],
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              value: experience[index],
                            );
                          }),
                          label: "Experience",
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
                          label: "Country",
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
                          hint: "grammar, speaking, listening",
                          dropItems: List.generate(
                              skills.length,
                              (index) => DropdownMenuItem<String>(
                                    child: Text(
                                      skills[index],
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    value: skills[index],
                                  )),
                          label: "Skills",
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
                          hint: "computer science",
                          dropItems: List.generate(
                              faculties.length,
                              (index) => DropdownMenuItem<String>(
                                    child: Text(
                                      faculties[index],
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    value: faculties[index],
                                  )),
                          label: "Faculty",
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
                          hint: "English",
                          dropItems: List.generate(
                              subjects.length,
                              (index) => DropdownMenuItem<String>(
                                    child: Text(
                                      subjects[index],
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    value: subjects[index],
                                  )),
                          label: "Teach In",
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
                            label: "Price",
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
                                        duration[index],
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
                            label: "Duration",
                            hint: "Per Month",
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
                        label: "About You",
                        hintText: "Write something about you..",
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
                          text: "Confirm"),
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
