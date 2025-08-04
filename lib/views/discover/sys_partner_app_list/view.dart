import 'package:flutter/material.dart';
import 'package:baby_app/model/sys_partner_type_model/sys_partner_type_model.dart';
import 'package:http_service/http_service.dart';

import 'station_list.dart';

class SysPartnerAppListView extends StatefulWidget {
  const SysPartnerAppListView({super.key, this.hideAppBar = false});

  final bool hideAppBar;

  @override
  State<SysPartnerAppListView> createState() => _SysPartnerAppListViewState();
}

class _SysPartnerAppListViewState extends State<SysPartnerAppListView>
    with SingleTickerProviderStateMixin {
  List<SysPartnerTypeModel> _partnerTypeList = [];
  late TabController tabController;

  void _getPartnerTypeList() async {
    try {
      List<SysPartnerTypeModel> result = await httpInstance.get(
          url: "sys/partner/getTypeList",
          complete: SysPartnerTypeModel.fromJson);
      setState(() {
        tabController = TabController(length: result.length, vsync: this);
        _partnerTypeList = result;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _getPartnerTypeList();
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: tabController,
      tabAlignment: TabAlignment.center,
      indicator: BoxDecoration(
        color: const Color(0xff009fe8),
        borderRadius: BorderRadius.circular(40),
      ),
      indicatorPadding: const EdgeInsets.only(top: 6, bottom: 6),
      // indicatorSize: TabBarIndicatorSize.tab,
      // indicatorColor: const Color(0xff009fe8),
      // indicatorPadding: const EdgeInsets.only(top: 10),
      // indicatorSize: TabBarIndicatorSize.label,
      labelColor: const Color(0xffffffff),
      unselectedLabelColor: const Color(0xffffffff).withValues(alpha: 0.6),
      tabs: _partnerTypeList
          .map((e) => Tab(
                child: Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Text(e.name ?? ''),
                ),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.hideAppBar ? null : AppBar(title: const Text('应用推荐')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _partnerTypeList.isNotEmpty
              ? Container(
                  alignment: Alignment.center,
                  child: _buildTabBar(),
                )
              : const SizedBox.shrink(),
          if (_partnerTypeList.isNotEmpty)
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: _partnerTypeList
                    .map((e) => SingleChildScrollView(
                          child:
                              SysPartnerAppListByStationView(type: e.code ?? 0),
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
