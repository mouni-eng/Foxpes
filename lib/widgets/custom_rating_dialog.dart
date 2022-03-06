import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/view_models/find_partner_cubit/cubit.dart';
import 'package:rating_dialog/rating_dialog.dart';

class CustomRatingDialog extends StatelessWidget {
  final LogInModel logInModel;

  CustomRatingDialog({required this.logInModel});

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      enableComment: false,
      // your app's name?
      title: Text(
        logInModel.firstName!,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      // encourage your user to leave a high rating?
      message: Text(
        'Feel free to give this service a rate upon your experience',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      // your app's logo?
      image: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: CachedNetworkImage(
            width: width(100),
            height: height(100),
            imageUrl: logInModel.image!,
          )),
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        FindPartnerCubit.get(context)
            .updateRating(logInModel.uid, response.rating.toInt());
      },
      submitButtonText: 'Submit',
      starSize: width(30),
    );
  }
}
