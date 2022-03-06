import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/view_models/Auth_Cubit/cubit.dart';
import 'package:movies_app/view_models/Auth_Cubit/states.dart';
import 'package:movies_app/widgets/custom_button.dart';
import 'package:movies_app/widgets/custom_toast.dart';

class UploadProfilePictureView extends StatelessWidget {
  final LogInModel logInModel;

  UploadProfilePictureView({required this.logInModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Photo", style: Theme.of(context).textTheme.headline1),
      ),
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: width(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height(157),
                ),
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    cubit.personalImage == null
                        ? SvgPicture.asset(
                            "assets/images/profile-circle.svg",
                            width: width(203),
                            height: height(203),
                          )
                        : Container(
                            width: width(203),
                            height: height(203),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image(
                                  image: FileImage(cubit.personalImage!),
                                  fit: BoxFit.cover,
                                ))),
                    Positioned(
                      bottom: height(10),
                      right: width(20),
                      child: Material(
                        color: Colors.white,
                        elevation: 2,
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          width: width(49),
                          height: height(49),
                          padding: EdgeInsets.all(width(12)),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              onPressed: () {
                                cubit.chooseImagre(key: "personalImage");
                              },
                              icon: SvgPicture.asset(
                                  "assets/images/camera-icon.svg")),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height(15),
                ),
                Text("Add Your Photo To Let People Knows You",
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: kHintTextColor,
                        )),
                SizedBox(
                  height: height(85),
                ),
                ConditionalBuilder(
                  condition: state is! SignUpGetUriLoadingState,
                  builder: (context) => CustomButton(
                    radius: 6,
                    function: () {
                      if (cubit.personalImage != null) {
                        cubit.uploadPersonalFile().then((value) {
                          cubit.signUp(
                              logInModel: logInModel, context: context);
                        });
                      } else {
                        showToast(
                            text: "Please choose image or skip",
                            state: ToastState.ERROR);
                      }
                    },
                    text: "upload photo",
                    isUpperCase: true,
                  ),
                  fallback: (context) => Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
                SizedBox(
                  height: height(10),
                ),
                ConditionalBuilder(
                  condition: state is! SignUpLoadingState,
                  builder: (context) => TextButton(
                    onPressed: () {
                      cubit.signUp(logInModel: logInModel, context: context);
                    },
                    child: Text(
                      "SKIP",
                      style: Theme.of(context).textTheme.subtitle2!,
                    ),
                  ),
                  fallback: (context) => Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
