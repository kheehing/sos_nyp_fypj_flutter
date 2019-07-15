import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

shadow(double marginLeft) {
  return Container(
    margin:
        EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(marginLeft)),
    height: ScreenUtil.getInstance().setHeight(100),
    width: ScreenUtil.getInstance().setWidth(290),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(.3),
            spreadRadius: 1,
            offset: Offset(10, 10),
            blurRadius: 15.0),
      ],
    ),
  );
}
