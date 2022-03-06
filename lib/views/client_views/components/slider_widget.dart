import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/slider_model.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/widgets/custom_text.dart';

class SliderWidget extends StatelessWidget {
  final CarouselController _controller = CarouselController();
  final int currentIndex;
  final dynamic Function(int, CarouselPageChangedReason)? onChanged;
  SliderWidget({required this.currentIndex, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: List.generate(
              sliderList.length,
              (index) => SliderData(
                    sliderModel: sliderList[index],
                  )),
          carouselController: _controller,
          options: CarouselOptions(
            height: height(154),
            initialPage: 0,
            onPageChanged: onChanged,
            viewportFraction: 1,
            enableInfiniteScroll: true,
            disableCenter: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(
          height: height(9),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              sliderList.length,
              (index) => currentIndex != index
                  ? Container(
                      width: width(4),
                      height: height(4),
                      margin: EdgeInsets.only(right: width(4)),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFEAEAF1),
                      ),
                    )
                  : Container(
                      width: width(16),
                      height: height(4),
                      margin: EdgeInsets.only(right: width(4)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: kPrimaryColor,
                      ),
                    ),
            ))
      ],
    );
  }
}

class SliderData extends StatelessWidget {
  final SliderModel sliderModel;
  SliderData({
    required this.sliderModel,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(165),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            width: double.infinity,
            height: height(145),
            decoration: BoxDecoration(
              color: Color(0xFFF7F7F9),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: width(16),
                top: height(35),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: sliderModel.title,
                    fontsize: 17.sp,
                    height: height(1.6),
                    color: kSecondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                      text: sliderModel.subTitle,
                      fontsize: 10.sp,
                      height: height(1.6),
                      color: kHintTextColor),
                ],
              ),
            ),
          ),
          Positioned(
            top: height(sliderModel.top),
            left: width(sliderModel.left),
            child: SvgPicture.asset(
              sliderModel.image,
              width: width(210),
              height: height(210),
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
