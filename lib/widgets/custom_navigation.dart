import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void navigateTo(context, Widget screen) {
  // Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          child: screen,
          duration: const Duration(milliseconds: 700),
          reverseDuration: const Duration(milliseconds: 700)));
}

void navigateToAndFinish(context, Widget screen) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => screen), (route) => false);
}