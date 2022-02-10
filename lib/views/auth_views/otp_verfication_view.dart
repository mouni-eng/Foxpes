import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/view_models/Auth_Cubit/cubit.dart';
import 'package:movies_app/view_models/Auth_Cubit/states.dart';
import 'package:movies_app/views/auth_views/parteners_signup_views/baby_sitter_views/babysitter_signup_view.dart';
import 'package:movies_app/views/auth_views/parteners_signup_views/drivers_views/driver_signup_view.dart';
import 'package:movies_app/views/auth_views/parteners_signup_views/teacher_views/teacher_signup_view.dart';
import 'package:movies_app/views/auth_views/upload_pic_view.dart';
import 'package:movies_app/widgets/custom_button.dart';
import 'package:movies_app/widgets/custom_navigation.dart';
import 'package:movies_app/widgets/custom_text.dart';
import 'package:movies_app/widgets/custom_toast.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OtpVerficationView extends StatefulWidget {
  final String phoneNumber;
  final String categorie;

  OtpVerficationView({required this.phoneNumber, required this.categorie});

  @override
  State<OtpVerficationView> createState() => _OtpVerficationViewState();
}

class _OtpVerficationViewState extends State<OtpVerficationView> {
  final TextEditingController _pinPutController = TextEditingController();
  String? verificationCode;
  String? pin;
  final FocusNode _pinPutFocusNode = FocusNode();

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(
      color: kPrimaryColor.withOpacity(0.4),
    ),
    borderRadius: BorderRadius.circular(6),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Confirm Code", style: Theme.of(context).textTheme.headline1),
      ),
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AuthCubit cubit = AuthCubit();
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width(16)),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height(64),
                    ),
                    Image.asset("assets/images/resend.png"),
                    SizedBox(
                      height: height(25),
                    ),
                    CustomText(
                      text: "Enter Verification Code",
                      fontsize: 18.sp,
                      textAlign: TextAlign.center,
                      height: height(1.5),
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: height(16),
                    ),
                    CustomText(
                      text: "Please enter verification code you've received",
                      fontsize: 13.sp,
                      textAlign: TextAlign.center,
                      height: height(1.5),
                      color: Color(0xFF707070),
                    ),
                    CustomText(
                      text: "+965 ${widget.phoneNumber}",
                      fontsize: 13.sp,
                      textAlign: TextAlign.center,
                      height: height(2.3),
                      color: kPrimaryColor.withOpacity(0.6),
                    ),
                    SizedBox(
                      height: height(30),
                    ),
                    PinPut(
                        fieldsCount: 6,
                        textStyle: TextStyle(
                          fontSize: 30.sp,
                          color: Color(0xFF7A7A7A),
                        ),
                        pinAnimationType: PinAnimationType.scale,
                        eachFieldWidth: width(45),
                        eachFieldHeight: height(55),
                        focusNode: _pinPutFocusNode,
                        controller: _pinPutController,
                        submittedFieldDecoration: pinPutDecoration,
                        selectedFieldDecoration: pinPutDecoration.copyWith(
                            border: Border.all(
                          color: kPrimaryColor,
                        )),
                        followingFieldDecoration: pinPutDecoration,
                        onChanged: (value) {
                          setState(() {
                            pin = value;
                          });
                        }),
                    SizedBox(
                      height: height(24),
                    ),
                    CustomButton(
                        radius: 6.0,
                        isUpperCase: true,
                        function: () async {
                          // TODO: confirm sent code
                          try {
                            FocusScope.of(context).unfocus();
                            await FirebaseAuth.instance
                                .signInWithCredential(
                                    PhoneAuthProvider.credential(
                                        verificationId: verificationCode!,
                                        smsCode: pin!))
                                .then((value) async {
                              if (value.user != null) {
                                navigateTo(context,
                                    cubit.nextSignUpScreen(context: context, logInModel: LogInModel(
                                      
                                    )));
                              }
                            });
                          } catch (e) {
                            FocusScope.of(context).unfocus();
                            showToast(
                                text: "Invalid otp", state: ToastState.ERROR);
                          }
                        },
                        text: "Confirm"),
                    SizedBox(
                      height: height(16),
                    ),
                    InkWell(
                      onTap: () async {
                        // TODO: reste code function
                        await _verifyPhone();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageIcon(
                            AssetImage("assets/icons/resend_icon.png"),
                          ),
                          SizedBox(
                            width: width(8),
                          ),
                          CustomText(
                            text: "Resend Code",
                            fontsize: 12.sp,
                            textAlign: TextAlign.center,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+20${widget.phoneNumber}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              showToast(text: "Verified", state: ToastState.SUCCESS);
            }
          }).catchError((error) {
            showToast(text: error.toString(), state: ToastState.ERROR);
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          showToast(text: e.toString(), state: ToastState.ERROR);
        },
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }
}
