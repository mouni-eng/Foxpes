import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/translations/locale_keys.g.dart';
import 'package:movies_app/view_models/Auth_Cubit/cubit.dart';
import 'package:movies_app/view_models/Auth_Cubit/states.dart';
import 'package:movies_app/views/auth_views/parteners_signup_views/drivers_views/driver_uploadphotos_view.dart';
import 'package:movies_app/widgets/custom_datepicker.dart';
import 'package:movies_app/widgets/custom_navigation.dart';
import 'package:movies_app/widgets/custom_button.dart';
import 'package:movies_app/widgets/custom_dropdown.dart';
import 'package:movies_app/widgets/custom_textformfield.dart';

class DriverSignUpView extends StatelessWidget {
  final TextEditingController _carNumberController = TextEditingController();
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phone;
  final String category;
  final String gender;
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _aboutMeController = TextEditingController();

  DriverSignUpView(
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
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, states) {},
        builder: (context, states) {
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
                          hint: "Nissan",
                          dropItems: List.generate(cars.length, (index) {
                            return DropdownMenuItem<String>(
                              child: Text(
                                cars[index],
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              value: cars[index],
                            );
                          }),
                          label: LocaleKeys.carType.tr(),
                          onChange: (value) {
                            cubit.chooseCarType(value!);
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
                      CustomFormField(
                        context: context,
                        controller: _carNumberController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "";
                          }
                          return null;
                        },
                        label: LocaleKeys.carNumber.tr(),
                        hintText: "90-24578",
                      ),
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
                                  DriverUploadPhotosView(
                                    firstName: firstName,
                                    lastName: lastName,
                                    email: email,
                                    password: password,
                                    phone: phone,
                                    gender: gender,
                                    category: category,
                                    birthDate: cubit.birthDate!,
                                    country: cubit.country!,
                                    experience: cubit.experience!,
                                    carType: cubit.carType!,
                                    carNumber: _carNumberController.text,
                                    price: _priceController.text,
                                    duration: cubit.duration!,
                                    aboutYou: _aboutMeController.text,
                                  ));
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
