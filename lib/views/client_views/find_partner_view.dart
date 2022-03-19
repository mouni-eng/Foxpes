import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/view_models/find_partner_cubit/cubit.dart';
import 'package:movies_app/view_models/find_partner_cubit/states.dart';
import 'package:movies_app/views/client_views/components/partner_widget.dart';
import 'package:movies_app/widgets/custom_filtring_widget.dart';
import 'package:movies_app/widgets/custom_search_form_field.dart';
import 'package:movies_app/widgets/custom_text.dart';

class FindPartnerView extends StatelessWidget {
  final String category;
  FindPartnerView({required this.category});
  @override
  Widget build(BuildContext context) {
    TextEditingController _searchEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: category,
          fontsize: 18.sp,
          color: kSecondaryColor,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) =>
            FindPartnerCubit()..getAllPartnersData(key: category),
        child: BlocConsumer<FindPartnerCubit, FindPartnerStates>(
          listener: (context, state) {},
          builder: (context, state) {
            FindPartnerCubit cubit = FindPartnerCubit.get(context);

            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height(5),
                    ),
                    SearchFormField(
                      searchEditingController: _searchEditingController,
                      hint: "Search your ${category.toLowerCase()}",
                      onChange: (value) {
                        cubit.searchPartnersData(key: category, name: value);
                      },
                    ),
                    SizedBox(
                      height: height(16),
                    ),
                    Row(
                      children: [
                        if (category == "Teacher")
                          FiltringWidget(
                            title: "Subjects",
                            category: category,
                          ),
                        SizedBox(
                          width: width(8),
                        ),
                        if (category != "Baby Sitter")
                          FiltringWidget(
                            title: "Gender",
                            category: category,
                          ),
                      ],
                    ),
                    SizedBox(
                      height: height(20),
                    ),
                    ConditionalBuilder(
                      condition: state is! GetAllPartnersLoadingState,
                      builder: (context) => ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => PartnerCard(
                                logInModel: cubit.allPartnersServices[index],
                                index: index,
                              ),
                          separatorBuilder: (context, index) => SizedBox(
                                height: height(15),
                              ),
                          itemCount: cubit.allPartnersServices.length),
                      fallback: (context) => Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
