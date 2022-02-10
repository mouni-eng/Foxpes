import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/services/helper/icon_broken.dart';
import 'package:movies_app/translate/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:movies_app/view_models/Services_cubit/cubit.dart';
import 'package:movies_app/view_models/Services_cubit/states.dart';
import 'package:movies_app/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeacherMessagesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServicesCubit, ServicesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ServicesCubit cubit = ServicesCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.chatList!.length > 0,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()
            ),
            itemBuilder: (context, index) =>
                buildTeacherChatItem(cubit.chatList![index], context),
            separatorBuilder: (context, index) => Divider(thickness: 0.8,),
            itemCount: cubit.chatList!.length,
          ),
          fallback: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(IconBroken.Info_Circle, size: 80.0,),
              SizedBox(
                height: 3.h,
              ),
              Center(child: Text('${LocaleKeys.noMessages1.tr()} \n ${LocaleKeys.noMessages2.tr()}', style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.center,)),
            ],
          ),
        );
      },
    );
  }
}



