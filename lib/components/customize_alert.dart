import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void CustomizeAlert(BuildContext context,
    {String? title, String? submit, Function()? okAction}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          width: 260.w,
          height: 125.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.w),
              Text(
                title ?? '温馨提示',
                style: TextStyle(
                    color: COLOR.hexColor("#333"),
                    fontWeight: FontWeight.w500,
                    fontSize: 15.w),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15.w, 22.w, 15.w, 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        width: 106.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: COLOR.hexColor("#eee"),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '取消',
                          style: TextStyle(
                              color: COLOR.hexColor("#666"),
                              fontSize: 14.w,
                              fontWeight: FontWeight.w500),
                        ),
                      ).onOpaqueTap(() {
                        Navigator.pop(context);
                      }),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        width: 106.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: COLOR.hexColor("#eb29c6"),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          submit ?? '',
                          style: TextStyle(
                              color: COLOR.hexColor("#fff"),
                              fontSize: 14.w,
                              fontWeight: FontWeight.w500),
                        ),
                      ).onOpaqueTap(() {
                        Navigator.pop(context);
                        if (okAction != null) {
                          okAction();
                        }
                      }),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
