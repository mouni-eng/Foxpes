import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/views/layout_views/layout_view.dart';
import 'package:movies_app/views/teacher_layout_views/teacher_layout_view.dart';
import 'package:movies_app/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:pinput/pin_put/pin_put.dart';

class OTPView extends StatefulWidget {
  final String phone;
  final String categorie;
  OTPView(this.phone, this.categorie);
  @override
  _OTPViewState createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: kSecondaryColor,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: kPrimaryColor,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                'We sent your code to +965-${widget.phone}',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: 16
                ),
              ),
            ),
          ),
          buildTimer(),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: PinPut(
              fieldsCount: 6,
              textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
              eachFieldWidth: 40.0,
              eachFieldHeight: 55.0,
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration,
              pinAnimationType: PinAnimationType.fade,
              onSubmit: (pin) async {
                try {
                  FocusScope.of(context).unfocus();
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                      verificationId: _verificationCode!, smsCode: pin))
                      .then((value) async {
                    if (value.user != null) {
                      showToast(text: "Verified", state: ToastState.SUCCESS);
                      if(widget.categorie == "teacher") {
                        navigateToAndFinish(context, TeacherLayoutView());
                      }else {
                        navigateToAndFinish(context, LayoutView());
                      }
                    }
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  showToast(text: "Invalid otp", state: ToastState.ERROR);
                }
              },
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Text("Didn't receive the code?", style: Theme.of(context).textTheme.bodyText2,),
                SizedBox(width: 10,),
                InkWell(
                  onTap: () {
                    _verifyPhone();
                  },
                  child: Text("RESEND", style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: kPrimaryColor,
                  ),),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+965${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              showToast(text: "Verified", state: ToastState.SUCCESS);
              if(widget.categorie == "teacher") {
                navigateToAndFinish(context, TeacherLayoutView());
              }else {
                navigateToAndFinish(context, LayoutView());
              }
            }
          }).catchError((error) { showToast(text: error.toString(), state: ToastState.ERROR);} );
        },
        verificationFailed: (FirebaseAuthException e) {
          showToast(text: e.toString(), state: ToastState.ERROR);
        },
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
    showToast(text: "code sent", state: ToastState.SUCCESS);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: Duration(seconds: 120),
          builder: (_, dynamic value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}