// ignore: import_of_legacy_library_into_null_safe
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/services/helper/icon_broken.dart';
import 'package:movies_app/services/helper/url_launcher.dart';
import 'package:movies_app/translate/locale_keys.g.dart';
import 'package:movies_app/view_models/Services_cubit/cubit.dart';
import 'package:movies_app/view_models/Services_cubit/states.dart';
import 'package:movies_app/views/layout_views/settings_view.dart';
import 'package:movies_app/views/teacher_layout_views/teacher_profile_view.dart';
import 'package:movies_app/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sizer/sizer.dart';


class TeacherSettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServicesCubit, ServicesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ServicesCubit cubit = ServicesCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.teacherModel != null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(2.w),
              child: Column(
                children: [
                  Card(
                    elevation: 3.0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Padding(
                      padding: EdgeInsets.all(4.w),
                      child: Container(
                        height: 24.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  ServicesCubit.get(context).teacherModel!.name!.split(" ").first, style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontSize: 22.sp,
                                ),),
                                Spacer(),
                                CircleAvatar(
                                  foregroundColor: Colors.white,
                                  backgroundColor: kPrimaryColor,
                                  radius: 24,
                                  backgroundImage: ServicesCubit.get(context).profileImage == null ? NetworkImage(ServicesCubit.get(context).teacherModel!.image!) : FileImage(ServicesCubit.get(context).profileImage!) as ImageProvider,),
                              ],
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      navigateTo(context, TeacherProfileView());
                                    },
                                    child: defaultTextField(
                                        size: 16.sp,
                                        text: LocaleKeys.settingsInfo1.tr(),
                                        color: Theme.of(context).accentColor)),
                                Icon(
                                  IconBroken.Arrow___Right_2,
                                  color: Theme.of(context).iconTheme.color,
                                  size: 16.sp,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h,),
                  Card(
                    elevation: 3.0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      height: 44.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                              trailing: Switch(
                                onChanged: (value) {
                                  cubit.changeNotification();
                                  if(value) {
                                    FirebaseMessaging.instance.subscribeToTopic("teachers");
                                  }else {
                                    FirebaseMessaging.instance.unsubscribeFromTopic("teachers");
                                  }
                                },
                                value: cubit.value,
                                activeColor: Theme.of(context).iconTheme.color,
                              ),
                              leading: Text(
                                LocaleKeys.settingsInfo2.tr(),
                                style: Theme.of(context).textTheme.bodyText1,
                              )),
                          Divider(),
                          InkWell(
                            onTap: () {
                              languageAlertDialog(context);
                            },
                            child: ListTile(
                                trailing: Padding(
                                  padding: EdgeInsets.all(2.w),
                                  child: Icon(IconBroken.More_Circle, color: Theme.of(context).iconTheme.color, size: 30.0,),
                                ),
                                leading: Text(
                                  LocaleKeys.settingsInfo5.tr(),
                                  style: Theme.of(context).textTheme.bodyText1,
                                )),
                          ),
                          Divider(),
                          InkWell(
                            onTap: () async{
                              await Utils.openEmail(
                                toEmail: 'foxpes.kwt@outlook.com',
                                subject: 'Get Help',
                                body: '',
                              );
                            },
                            child: ListTile(
                                trailing: Padding(
                                  padding: EdgeInsets.all(2.w),
                                  child: Icon(IconBroken.Info_Circle, color: Theme.of(context).iconTheme.color, size: 30.0,),
                                ),
                                leading: Text(
                                  LocaleKeys.settingsInfo3.tr(),
                                  style: Theme.of(context).textTheme.bodyText1,
                                )),
                          ),
                          Divider(),
                          InkWell(
                            onTap: () async{
                              await signOutAlertDialog(context, () {cubit.teacherSignOut(context);});
                            },
                            child: ListTile(
                                trailing: Padding(
                                  padding: EdgeInsets.all(2.w),
                                  child: Icon(IconBroken.Logout, color: Theme.of(context).iconTheme.color, size: 30.0,),
                                ),
                                leading: Text(
                                  LocaleKeys.settingsInfo4.tr(),
                                  style: Theme.of(context).textTheme.bodyText1,
                                )),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}

