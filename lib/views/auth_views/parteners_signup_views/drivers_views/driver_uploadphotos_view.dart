import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/view_models/Auth_Cubit/cubit.dart';
import 'package:movies_app/view_models/Auth_Cubit/states.dart';
import 'package:movies_app/views/auth_views/otp_verfication_view.dart';
import 'package:movies_app/views/auth_views/upload_pic_view.dart';
import 'package:movies_app/widgets/custom_button.dart';
import 'package:movies_app/widgets/custom_navigation.dart';
import 'package:movies_app/widgets/custom_text.dart';
import 'package:movies_app/widgets/custom_toast.dart';
import 'package:movies_app/widgets/custom_uploadphoto_card.dart';

class DriverUploadPhotosView extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phone;
  final String category;
  final String gender;
  final String carType;
  final String carNumber;
  final String birthDate;
  final String country;
  final String experience;
  final String price;
  final String duration;
  final String aboutYou;

  DriverUploadPhotosView(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.phone,
      required this.gender,
      required this.category,
      required this.carType,
      required this.carNumber,
      required this.birthDate,
      required this.country,
      required this.experience,
      required this.price,
      required this.duration,
      required this.aboutYou});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width(16)),
        child: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
            AuthCubit cubit = AuthCubit.get(context);
            if (state is SignUpGetUriSuccesState) {
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
                      birthDate: birthDate,
                      country: country,
                      experience: cubit.experience!,
                      careType: carType,
                      carNumber: carNumber,
                      price: price,
                      duration: duration,
                      aboutYou: aboutYou,
                      idCardImage: cubit.idCardUri,
                      licienceCardImage: cubit.cardLiscenseUri,
                      carPlateImage: cubit.carPlateUri,
                      carImages: cubit.carImagesUri,
                    ),
                  ));
            }
          },
          builder: (context, state) {
            AuthCubit cubit = AuthCubit.get(context);
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cubit.idCard == null
                      ? CustomUploadPhotosCard(
                          title: "Upload your id card",
                          onPressed: () {
                            cubit.chooseImagre(key: "idCard");
                          },
                        )
                      : Container(
                          width: double.infinity,
                          height: height(155),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image(
                              image: FileImage(cubit.idCard!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  SizedBox(
                    height: height(24),
                  ),
                  cubit.cardLiscense == null
                      ? CustomUploadPhotosCard(
                          title: "Upload your card license",
                          onPressed: () {
                            cubit.chooseImagre(key: "cardLiscense");
                          },
                        )
                      : Container(
                          width: double.infinity,
                          height: height(155),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image(
                              image: FileImage(cubit.cardLiscense!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  SizedBox(
                    height: height(24),
                  ),
                  cubit.carPlate == null
                      ? CustomUploadPhotosCard(
                          title: "Upload Car Plate",
                          onPressed: () {
                            cubit.chooseImagre(key: "carPlate");
                          },
                        )
                      : Container(
                          width: double.infinity,
                          height: height(155),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image(
                              image: FileImage(cubit.carPlate!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  SizedBox(
                    height: height(24),
                  ),
                  Text(
                    "Upload minimum 2 pictures of your car",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  SizedBox(
                    height: height(8),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            cubit.chooseImagre(key: "otherImages");
                          },
                          child: Container(
                            width: width(77),
                            height: height(70),
                            decoration: BoxDecoration(
                              color: Color(0xFFF8F8F8),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt_rounded,
                                  color: kPrimaryColor,
                                ),
                                SizedBox(
                                  height: height(8),
                                ),
                                CustomText(
                                  text: "Add Photo",
                                  fontsize: 9.sp,
                                  color: kPrimaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (cubit.carImages!.length > 0)
                          Row(
                            children: List.generate(
                                cubit.carImages!.length,
                                (index) => Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: width(10)),
                                      width: width(77),
                                      height: height(70),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: Image(
                                            image: FileImage(
                                                cubit.carImages![index]),
                                            fit: BoxFit.cover),
                                      ),
                                    )),
                          )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height(24),
                  ),
                  ConditionalBuilder(
                    condition: state is! SignUpGetUriLoadingState,
                    builder: (context) => CustomButton(
                      isUpperCase: true,
                      function: () {
                        if (cubit.idCard == null ||
                            cubit.carPlate == null ||
                            cubit.cardLiscense == null ||
                            cubit.carImages!.length == 0) {
                          showToast(
                              text: "Please complete your data",
                              state: ToastState.ERROR);
                        } else {
                          cubit.uploadFile();
                        }
                      },
                      text: "Confirm",
                    ),
                    fallback: (context) =>
                        Center(child: CircularProgressIndicator.adaptive()),
                  ),
                  SizedBox(
                    height: height(24),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
