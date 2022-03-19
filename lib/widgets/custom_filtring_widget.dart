import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/view_models/find_partner_cubit/cubit.dart';
import 'package:movies_app/view_models/find_partner_cubit/states.dart';
import 'package:movies_app/widgets/custom_button.dart';
import 'package:movies_app/widgets/custom_text.dart';

class FiltringWidget extends StatelessWidget {
  final String title;
  final String category;

  FiltringWidget({required this.title, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FindPartnerCubit.get(context).getAllPartnersData(key: category);
        showModalBottomSheet(
            context: context,
            barrierColor: Colors.black.withOpacity(0.8),
            backgroundColor: Colors.transparent,
            builder: (context) => Container(
                  height: height(416),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width(16),
                      vertical: height(16),
                    ),
                    child: FiltringListWidget(title: title),
                  ),
                )).then((value) {
          if (title == "Subjects") {
            FindPartnerCubit.get(context).getSubjectFilteredData();
          } else {
            FindPartnerCubit.get(context).getGenderFilteredData();
          }
        });
      },
      child: Container(
        width: width(92),
        height: height(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Color(0xFFF6F6F6),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: width(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(text: title, fontsize: 13.sp, color: kHintTextColor),
            SvgPicture.asset(
              "assets/icons/arrow_drop.svg",
              width: width(9),
              height: height(5),
            ),
          ],
        ),
      ),
    );
  }
}

class FiltringListWidget extends StatelessWidget {
  const FiltringListWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FindPartnerCubit, FindPartnerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        FindPartnerCubit cubit = FindPartnerCubit.get(context);
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      text: title, fontsize: 16.sp, color: kSecondaryColor),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      "assets/icons/close.svg",
                      width: width(12),
                      height: height(12),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 0.8,
              ),
              SizedBox(
                height: height(10),
              ),
              Column(
                children: List.generate(
                  title == "Subjects" ? subjects.length : gender.length,
                  (index) => Column(
                    children: [
                      if (title == "Subjects")
                        Padding(
                          padding: EdgeInsets.only(left: width(5)),
                          child: SubjectCheckBoxTile(
                            cubit: cubit,
                            title: title,
                            index: index,
                          ),
                        ),
                      if (title == "Gender")
                        GenderCheckBoxTile(
                          cubit: cubit,
                          title: title,
                          index: index,
                        ),
                      SizedBox(
                        height: height(10),
                      ),
                      Divider(
                        thickness: 0.8,
                      ),
                      SizedBox(
                        height: height(15),
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                isUpperCase: true,
                function: () {
                  Navigator.pop(context);
                },
                text: "Submit",
                width: width(116),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SubjectCheckBoxTile extends StatelessWidget {
  const SubjectCheckBoxTile({
    Key? key,
    required this.cubit,
    required this.title,
    required this.index,
  }) : super(key: key);

  final FindPartnerCubit cubit;
  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: width(16),
          height: height(16),
          child: Checkbox(
              value: subjects[index] == cubit.subjectFilter ? true : false,
              onChanged: (value) {
                cubit.filterSubjectPartnerData(
                  subject: subjects[index],
                );
              }),
        ),
        SizedBox(
          width: width(8),
        ),
        CustomText(
            text: subjects[index], fontsize: 15.sp, color: kHintTextColor),
      ],
    );
  }
}

class GenderCheckBoxTile extends StatelessWidget {
  const GenderCheckBoxTile({
    Key? key,
    required this.cubit,
    required this.title,
    required this.index,
  }) : super(key: key);

  final FindPartnerCubit cubit;
  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: width(16),
          height: height(16),
          child: Checkbox(
              value: gender[index] == cubit.genderFilter ? true : false,
              onChanged: (value) {
                cubit.filterGenderPartnerData(
                  gender: gender[index],
                );
              }),
        ),
        SizedBox(
          width: width(8),
        ),
        CustomText(text: gender[index], fontsize: 15.sp, color: kHintTextColor),
      ],
    );
  }
}
