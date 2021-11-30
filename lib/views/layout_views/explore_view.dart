// ignore: import_of_legacy_library_into_null_safe
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/subject_model.dart';
import 'package:movies_app/translate/locale_keys.g.dart';
import 'package:movies_app/view_models/explore_cubit/cubit.dart';
import 'package:movies_app/view_models/explore_cubit/states.dart';
import 'package:movies_app/widgets.dart';
import 'package:easy_localization/easy_localization.dart';

class ExploreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<SubjectsModel> translatedSubjectsList = [
      SubjectsModel(
          title: LocaleKeys.Arabic.tr(),
          image: "assets/images/arabic.png"),
      SubjectsModel(
          title: LocaleKeys.Art.tr(),
          image: "assets/images/tools.png"),
      SubjectsModel(
          title: LocaleKeys.Biology.tr(),
          image: "assets/images/bio.png"),
      SubjectsModel(
          title: LocaleKeys.Chemistry.tr(),
          image: "assets/images/chemistry.png"),
      SubjectsModel(
          title: LocaleKeys.English.tr(),
          image: "assets/images/english.png"),
      SubjectsModel(
          title: LocaleKeys.French.tr(),
          image: "assets/images/french.png"),
      SubjectsModel(
          title: LocaleKeys.General.tr(),
          image: "assets/images/general.png"),
      SubjectsModel(
          title: LocaleKeys.Geology.tr(),
          image: "assets/images/geo.png"),
      SubjectsModel(
          title: LocaleKeys.German.tr(),
          image: "assets/images/germany.png"),
      SubjectsModel(
          title: LocaleKeys.History.tr(),
          image: "assets/images/history.png"),
      SubjectsModel(
          title: LocaleKeys.Italian.tr(),
          image: "assets/images/italy.png"),
      SubjectsModel(
          title: LocaleKeys.Math.tr(),
          image: "assets/images/math.png"),
      SubjectsModel(
          title: LocaleKeys.Philosophy.tr(),
          image: "assets/images/philo.png"),
      SubjectsModel(
          title: LocaleKeys.Physics.tr(),
          image: "assets/images/physics.png"),
      SubjectsModel(
          title: LocaleKeys.Programming.tr(),
          image: "assets/images/coding.png"),
      SubjectsModel(
          title: LocaleKeys.Quran.tr(),
          image: "assets/images/quran.png"),
      SubjectsModel(
          title: LocaleKeys.Religion.tr(),
          image: "assets/images/pray.png"),
      SubjectsModel(
          title: LocaleKeys.Science.tr(),
          image: "assets/images/science.png"),
      SubjectsModel(
          title: LocaleKeys.Spanish.tr(),
          image: "assets/images/spain.png"),
      SubjectsModel(
          title: LocaleKeys.SocialStudies.tr(),
          image: "assets/images/ss.png"),
    ];
    return BlocConsumer<ExploreCubit, ExploreStates>(
      listener: (context, states) {},
      builder: (context, states) {
        ExploreCubit cubit = ExploreCubit.get(context);
        return ConditionalBuilder(
          condition: states is! GetUserChatDataLoadingState && states is! GetUserLoadingState,
          builder: (context) => cubit.userModel != null ? SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.cloud,),
                        SizedBox(width: 10.0,),
                        Text("${LocaleKeys.welcome.tr()} ${cubit.userModel!.name!.split(" ").first}", style: Theme.of(context).textTheme.bodyText2),
                      ],
                    ),
                    SizedBox(height: 15.0,),
                    Text(LocaleKeys.infoBar.tr(), style: Theme.of(context).textTheme.bodyText1,),
                    SizedBox(height: 15.0,),
                    Card(
                      elevation: 3.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${cubit.userModel!.name!.split(" ").first} (${LocaleKeys.info.tr()})', style: Theme.of(context).textTheme.bodyText1,),
                                SizedBox(height: 10.0,),
                                Text('National System (Kuwait)', style: Theme.of(context).textTheme.bodyText2,),
                              ],
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 20.0,
                                foregroundColor: Colors.white,
                                backgroundColor: kPrimaryColor,
                                backgroundImage: cubit.profileImage == null ? NetworkImage(cubit.userModel!.image!) : FileImage(cubit.profileImage!) as ImageProvider,),
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0,),
                    Text(LocaleKeys.services.tr(), style: Theme.of(context).textTheme.bodyText1,),
                    SizedBox(height: 15.0,),
                    Container(
                      height: 100.0,
                      child: buildServicesList(context),
                    ),
                    SizedBox(height: 25.0,),
                    Text(LocaleKeys.availableSubjects.tr(), style: Theme.of(context).textTheme.bodyText1,),
                    SizedBox(height: 15.0,),
                    Container(
                      height: 155.0,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildSuggestionList(context, translatedSubjectsList[index]),
                        separatorBuilder: (context, index) => SizedBox(width: 20.0,),
                        itemCount: translatedSubjectsList.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ) : Center(child: Text(
            'No current user',
          ),),
          fallback: (context) => Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}
