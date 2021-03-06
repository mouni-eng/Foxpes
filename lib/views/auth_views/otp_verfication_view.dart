import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/translations/locale_keys.g.dart';
import 'package:movies_app/views/auth_views/upload_pic_view.dart';
import 'package:movies_app/widgets/custom_button.dart';
import 'package:movies_app/widgets/custom_navigation.dart';
import 'package:movies_app/widgets/custom_text.dart';
import 'package:movies_app/widgets/custom_toast.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OtpVerficationView extends StatefulWidget {
  final LogInModel logInModel;

  OtpVerficationView({required this.logInModel});

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
        title: Text(LocaleKeys.confirmCode.tr(),
            style: Theme.of(context).textTheme.headline1),
      ),
      body: SingleChildScrollView(
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
                  text: LocaleKeys.enterVerificationCode.tr(),
                  fontsize: 18.sp,
                  textAlign: TextAlign.center,
                  height: height(1.5),
                  color: Colors.black,
                ),
                SizedBox(
                  height: height(16),
                ),
                CustomText(
                  text: LocaleKeys.pleaseEnterVerification.tr(),
                  fontsize: 13.sp,
                  textAlign: TextAlign.center,
                  height: height(1.5),
                  color: Color(0xFF707070),
                ),
                CustomText(
                  text: "+965 ${widget.logInModel.phone}",
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
                      print(pin);
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
                            .signInWithCredential(PhoneAuthProvider.credential(
                                verificationId: verificationCode ?? "",
                                smsCode: pin!))
                            .then((value) async {
                          if (value.user != null) {
                            navigateTo(
                                context,
                                UploadProfilePictureView(
                                    logInModel: widget.logInModel));
                          }
                        });
                      } catch (e) {
                        FocusScope.of(context).unfocus();
                        print(e.toString());
                        showToast(text: "Invalid otp", state: ToastState.ERROR);
                      }
                    },
                    text: LocaleKeys.confirm.tr()),
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
                        text: LocaleKeys.resendCode.tr(),
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
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+965${widget.logInModel.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              navigateTo(context,
                  UploadProfilePictureView(logInModel: widget.logInModel));
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
          if (this.mounted) {
            setState(() {
              verificationCode = verficationID;
            });
            print(verificationCode);
          }
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          if (this.mounted) {
            setState(() {
              verificationCode = verificationID;
              print(verificationCode);
            });
          }
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
