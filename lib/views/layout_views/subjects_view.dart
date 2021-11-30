import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/subject_model.dart';
import 'package:movies_app/translate/locale_keys.g.dart';
import 'package:movies_app/widgets.dart';

class SubjectsView extends StatelessWidget {
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

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.chooseSubject.tr(), style: Theme.of(context).textTheme.bodyText1!.copyWith(
          color: Colors.black,
        ),),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => buildSubjectsList(context, translatedSubjectsList[index], fields[index]),
                separatorBuilder: (context, index) => Divider(thickness: 1,),
                itemCount: translatedSubjectsList.length,
            )
          ],
        ),
      ),
    );
  }
}
