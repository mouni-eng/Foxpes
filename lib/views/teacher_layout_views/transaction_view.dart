import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/view_models/App_Cubit/cubit.dart';
import 'package:movies_app/views/teacher_layout_views/teacher_layout_view.dart';
import 'package:movies_app/widgets.dart';
import 'package:sizer/sizer.dart';

class TransactionView extends StatelessWidget {
  final String? sessionId, status, image;
  TransactionView({required this.status, this.sessionId, required this.image});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Column(
            children: [
              Center(child: Text("Transaction $status", style: Theme.of(context).textTheme.bodyText1,)),
              SizedBox(height: 2.h,),
              Expanded(
                  flex: 2,
                  child: SvgPicture.asset(image!)),
              SizedBox(height: 2.h,),
              Expanded(child: Column(
                children: [
                  if(sessionId != null)
                  Text("SessionId is $sessionId \nPlease Remember this id", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText1,),
                  SizedBox(height: 2.h,),
                  defaultButton(function: (){
                    AppCubit.get(context).teacherChangeBottomNav(0);
                    navigateToAndFinish(context, TeacherLayoutView());
                  }, text: "Return To Home"),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
