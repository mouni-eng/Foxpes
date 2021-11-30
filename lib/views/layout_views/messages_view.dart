// ignore: import_of_legacy_library_into_null_safe
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/services/helper/icon_broken.dart';
import 'package:movies_app/translate/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:movies_app/view_models/explore_cubit/cubit.dart';
import 'package:movies_app/view_models/explore_cubit/states.dart';
import 'package:movies_app/widgets.dart';

class MessagesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<ExploreCubit, ExploreStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ExploreCubit cubit = ExploreCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.userChatList!.length > 0,
            builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()
              ),
              itemBuilder: (context, index) =>
                  buildUserChatItem(cubit.userChatList![index], context),
              separatorBuilder: (context, index) => Divider(thickness: 0.8,),
              itemCount: cubit.userChatList!.length,
            ),
            fallback: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(IconBroken.Info_Circle, size: 80.0,),
                SizedBox(
                  height: 20.0,
                ),
                Center(child: Text('${LocaleKeys.noMessages1.tr()} \n ${LocaleKeys.noMessages2.tr()}', style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.center,)),
              ],
            ),
          );
        },
      );

  }
}