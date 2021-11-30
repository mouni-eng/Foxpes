import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/services/helper/icon_broken.dart';
import 'package:movies_app/view_models/Services_cubit/cubit.dart';
import 'package:movies_app/view_models/Services_cubit/states.dart';
import 'package:movies_app/widgets.dart';
import '../../constants.dart';

class TeacherProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    TextEditingController _emailEditingController = TextEditingController();
    TextEditingController _nameEditingController = TextEditingController();
    TextEditingController _phoneEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile', style: Theme.of(context).textTheme.bodyText1!.copyWith(
          color: Colors.black,
          fontSize: 18.0,
        ),),
        centerTitle: true,
        leading: IconButton(icon: Icon(IconBroken.Close_Square, color: Colors.red,), onPressed: () {Navigator.pop(context);},),
      ),
      body: BlocConsumer<ServicesCubit, ServicesStates>(
        listener: (context, states) {},
        builder: (context, states) {

          ServicesCubit cubit = ServicesCubit.get(context);
          _emailEditingController.text = cubit.teacherModel!.email!;
          _nameEditingController.text = cubit.teacherModel!.name!;
          _phoneEditingController.text = cubit.teacherModel!.phone!;

          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    if(states is TeacherUpdateLoadingState)
                    LinearProgressIndicator(),
                    SizedBox(height: 10.0,),
                    Center(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 40.0,
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blueGrey,
                            backgroundImage: cubit.profileImage == null ? NetworkImage(cubit.teacherModel!.image!) : FileImage(cubit.profileImage!) as ImageProvider,),
                          CircleAvatar(
                              radius: 15.0,
                              foregroundColor: Colors.white,
                              backgroundColor: kPrimaryColor,
                              child: IconButton(
                                icon: Icon(IconBroken.Camera, size: 10.0,),
                                onPressed: () {
                                  cubit.uploadProfileImage(
                                      name: _nameEditingController.text,
                                      phone: _phoneEditingController.text,
                                      email: _emailEditingController.text
                                  );
                                },
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    defaultFormField(
                        context: context,
                        controller: _nameEditingController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your Name";
                          }
                          return null;
                        },
                        label: "Name",
                        prefix: IconBroken.Profile),
                    SizedBox(
                      height: 30.0,
                    ),
                    defaultFormField(
                        context: context,
                        controller: _emailEditingController,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your Email";
                          }
                          return null;
                        },
                        label: "Email",
                        prefix: IconBroken.User),
                    SizedBox(
                      height: 30.0,
                    ),
                    defaultFormField(
                      context: context,
                      controller: _phoneEditingController,
                      type: TextInputType.phone,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Your Phone Number";
                        }
                        return null;
                      },
                      label: "Phone Number",
                      prefix: IconBroken.Call,
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    defaultButton(function: (){
                      if (_formKey.currentState!.validate()) {
                        cubit.updateTeacher(
                          name: _nameEditingController.text,
                          phone: _phoneEditingController.text,
                          email: _emailEditingController.text,
                        );
                      }
                    }, text: "Save", radius: 25.0,),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
