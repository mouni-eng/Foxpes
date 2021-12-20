// ignore: import_of_legacy_library_into_null_safe
import 'package:conditional_builder/conditional_builder.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/services_model.dart';
import 'package:movies_app/services/helper/icon_broken.dart';
import 'package:movies_app/view_models/Services_cubit/cubit.dart';
import 'package:movies_app/view_models/Services_cubit/states.dart';
import 'package:movies_app/widgets.dart';
import 'package:sizer/sizer.dart';

class AddServicesView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    TextEditingController _hourRateEditingController = TextEditingController();
    TextEditingController _aboutMeEditingController = TextEditingController();
    TextEditingController _ageEditingController = TextEditingController();
    TextEditingController _educationEditingController = TextEditingController();
    TextEditingController _experienceEditingController = TextEditingController();

    return BlocConsumer<ServicesCubit, ServicesStates>(
      listener: (context, state) {
        if (state is AddServiceSuccessState) {
          showToast(text: "Success!", state: ToastState.SUCCESS);
        } else if (state is AddServiceErrorState) {
          showToast(text: state.error.toString(), state: ToastState.ERROR);
        }
      },
      builder: (context, state) {
        ServicesCubit cubit = ServicesCubit.get(context);

        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: defaultFormField(
                            context: context,
                            controller: _ageEditingController,
                            type: TextInputType.datetime,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Your Age";
                              }
                              return null;
                            },
                            label: "Age",
                            prefix: IconBroken.Calendar),
                      ),
                      SizedBox(width: 2.5.w,),
                      Expanded(
                        child: defaultFormField(
                            context: context,
                            controller: _hourRateEditingController,
                            type: TextInputType.number,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Your Hour/Rate";
                              }
                              return null;
                            },
                            label: "Hour/Rate",
                            prefix: IconBroken.Wallet),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h,),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CountryCodePicker(
                      onChanged: (value) {
                        cubit.chooseCountry(value.flagUri!, value.name);
                      },
                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                      initialSelection: '+965',
                      favorite: ['+965','+20'],
                      // optional. Shows only country name and flag
                      showCountryOnly: true,
                      // optional. Shows only country name and flag when popup is closed.
                      showOnlyCountryWhenClosed: true,
                      // optional. aligns the flag and the Text left
                      alignLeft: true,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  defaultFormField(
                    maxLines: 2,
                    context: context,
                    controller: _aboutMeEditingController,
                    type: TextInputType.text,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Write about yourSelf ....";
                      }
                      return null;
                    },
                    label: "About Me",
                    prefix: IconBroken.Info_Circle,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  defaultFormField(
                    maxLines: 2,
                    context: context,
                    controller: _educationEditingController,
                    type: TextInputType.text,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your Education";
                      }
                      return null;
                    },
                    label: "Education",
                    prefix: IconBroken.Bag_2,),
                  SizedBox(
                    height: 2.h,
                  ),
                  defaultFormField(
                    maxLines: 2,
                    context: context,
                    controller: _experienceEditingController,
                    type: TextInputType.text,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Your Experience";
                      }
                      return null;
                    },
                    label: "Experience",
                    prefix: IconBroken.Paper_Plus,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  ConditionalBuilder(
                    condition: state is! AddServiceLoadingState,
                    builder: (context) => defaultButton(function: (){
                      if (_formKey.currentState!.validate()) {
                          cubit.uploadService(
                              ServicesModel(
                                nationality: cubit.nationality,
                                aboutMe: _aboutMeEditingController.text,
                                name: cubit.teacherModel!.name ?? "",
                                uid: uId ?? "",
                                image: cubit.teacherModel!.image ?? "",
                                education: _educationEditingController.text,
                                experience: _experienceEditingController.text,
                                age: _ageEditingController.text,
                                hourRate: _hourRateEditingController.text,
                                rank: 0,
                                rating: "NA",
                                field: cubit.teacherModel!.field ?? "",
                                flag: cubit.flagUri,
                              )
                          );
                          _hourRateEditingController.clear();
                          _aboutMeEditingController.clear();
                          _ageEditingController.clear();
                          _educationEditingController.clear();
                          _experienceEditingController.clear();
                      }
                    }, text: "Submit", radius: 25.0, isUpperCase: false),
                    fallback: (context) => Center(child: CircularProgressIndicator(),),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
