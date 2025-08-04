import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baby_app/components/image_view.dart';
import 'package:baby_app/model/sys_partner_station_cell_model/partner_list.dart';
import 'package:baby_app/utils/ad_jump.dart';
import 'package:http_service/http_service.dart';

class PartnerItemCell extends StatelessWidget {
  const PartnerItemCell({super.key, required this.app, required this.style});

  final int style;

  final PartnerList app;

  Future<void> fetchClickReport(String id) async {
    return await httpInstance.post(url: "sys/partner/click/report", body: {
      "id": id,
    });
  }

  void _onTap() async {
    fetchClickReport(app.id!);
    jumpExternalURL(app.link!);
  }

// SysPartnerCellModel
  Widget _buildTwoStyle() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.w)),
          child: SizedBox(
            width: 60.w,
            height: 60.w,
            child: ImageView(src: app.icon ?? ''),
          ),
        ),
        SizedBox(
          width: 7.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                app.name ?? '',
                style: TextStyle(
                  fontSize: 14.w,
                  color: const Color(0xffffffff),
                ),
              ),
              Text(
                app.desc ?? '',
                style: TextStyle(
                  fontSize: 11.w,
                  color: const Color(0xffffffff).withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xff009fe8),
            // gradient: const LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [
            //     Color(0xFFF78248), // #F78248
            //     Color(0xFFF52C0F), // #F52C0F
            //     Color(0xFFF5019A), // #F5019A
            //   ],
            //   stops: [0.0, 0.44, 1.0], // 渐变的停止位置
            // ),
            borderRadius: BorderRadius.circular(24), // 设置圆角
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            "立即下载",
            style: TextStyle(fontSize: 12.w, color: const Color(0xffffffff)),
          ),
        )
      ],
    );
  }

  Widget _buildOneStyle() {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1 / 1, // 正方形图片
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.w)),
            child: ImageView(
              src: app.icon ?? '',
            ),
          ),
        ),
        SizedBox(
          height: 6.w,
        ),
        Text(
          app.name ?? '',
          style: TextStyle(
            fontSize: 11.w,
            color: const Color(0xffffffff),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onTap();
      },
      child: style == 1 ? _buildOneStyle() : _buildTwoStyle(),
    );
  }
}
