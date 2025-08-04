import 'package:baby_app/model/sys_partner_station_cell_model/partner_list.dart';
import 'package:baby_app/model/sys_partner_station_cell_model/sys_partner_station_cell_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:baby_app/components/partner_item_cell/partner_item_cell.dart';
import 'package:http_service/http_service.dart';

class SysPartnerAppListByStationView extends StatefulWidget {
  const SysPartnerAppListByStationView({
    super.key,

    /// 0: 列表 1: 宫格
    // required this.styleType,
    required this.type,
  });

  // final int styleType;

  final int type;

  @override
  State<SysPartnerAppListByStationView> createState() =>
      _SysPartnerAppListByStationViewState();
}

class _SysPartnerAppListByStationViewState
    extends State<SysPartnerAppListByStationView> {
  List<SysPartnerStationCellModel> _list = [];

  @override
  void initState() {
    super.initState();
    initList();
  }

  void initList() async {
    List<SysPartnerStationCellModel> result = await httpInstance.get(
        url: "sys/partner/list",
        queryMap: {"type": widget.type},
        complete: SysPartnerStationCellModel.fromJson);
    if (result.isNotEmpty) {
      setState(() {
        _list = result;
      });
    }
  }

  Widget _buildTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.5),
            color: const Color(0xff009fe8),
          ),
          width: 4.w,
          height: 15.w,
        ),
        SizedBox(
          width: 6.w,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 16.w,
            color: const Color(0xffffffff),
            fontWeight: FontWeight.w500,
            letterSpacing: 0,
          ),
        )
      ],
    );
  }

  Widget _buildGridListByStyleTypeOne(List<PartnerList> partnerList) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: StaggeredGrid.count(
        mainAxisSpacing: 6.w,
        crossAxisSpacing: 12.w,
        crossAxisCount: 5,
        children:
            partnerList.map((e) => PartnerItemCell(app: e, style: 1)).toList(),
      ),
    );
  }

  Widget _buildListListByStyleTypeTwo(List<PartnerList> partnerList) {
    return ListView.separated(
      padding: const EdgeInsets.only(left: 10, right: 10),
      shrinkWrap: true, // 根据内容大小收缩
      physics: const NeverScrollableScrollPhysics(), // 禁用滚动
      itemCount: partnerList.length,
      itemBuilder: (context, index) {
        return PartnerItemCell(app: partnerList[index], style: 2);
      },
      separatorBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 9.w),
          child: const Divider(
            color: Color(0xfff0f0f0),
            height: 1,
          ),
        );
      },
    );
  }

  Widget _buildStation(SysPartnerStationCellModel station) {
    return Column(
      children: [
        if (station.name?.isNotEmpty ?? false) _buildTitle(station.name ?? ''),
        SizedBox(
          height: 12.w,
        ),
        station.viewType == 1
            ? _buildGridListByStyleTypeOne(station.partnerList ?? [])
            : _buildListListByStyleTypeTwo(station.partnerList ?? []),
        SizedBox(
          height: 10.h,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _list.map((e) => _buildStation(e)).toList(),
    );
  }
}
