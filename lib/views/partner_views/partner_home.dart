import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/view_models/Client_cubit/cubit.dart';
import 'package:movies_app/view_models/Client_cubit/states.dart';

class PartnerHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<ClientCubit, ClientStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ClientCubit cubit = ClientCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: width(16)),
              child: ConditionalBuilder(
                  condition: state is! GetUserDataLoadingState,
                  builder: (context) => cubit.screens[1],
                  fallback: (context) => Center(
                        child: CircularProgressIndicator.adaptive(),
                      )),
            ),
          );
        });
  }
}
