import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuple/tuple.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

import '../../../../components/image_view.dart';
import '../../../../components/tab_bar_indicator/easy_fixed_indicator.dart';
import '../../../generate/app_image_path.dart';
import 'tab_child_record_page.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  List<Tuple2<String, int>> tabs = const [
    Tuple2("图片换脸", 2),
    Tuple2("视频换脸", 3),
    Tuple2("图片去衣", 1),
    Tuple2("视频去衣", 5),
    Tuple2("GIF视频", 6),
  ];

  @override
  void initState() {
    tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          TabChildRecordPage(tabIndex: tabs[0].item2).keepAlive,
          TabChildRecordPage(tabIndex: tabs[1].item2).keepAlive,
          TabChildRecordPage(tabIndex: tabs[2].item2).keepAlive,
          TabChildRecordPage(tabIndex: tabs[3].item2).keepAlive,
          TabChildRecordPage(tabIndex: tabs[4].item2).keepAlive,
        ],
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text('记录'),
      flexibleSpace: const FlexibleSpaceBar(
        background: ImageView(src: AppImagePath.app_default_appbar_bg),
      ),
      bottom: TabBar(
        controller: tabController,
        tabs:
            List.generate(tabs.length, (index) => Tab(text: tabs[index].item1)),
        isScrollable: false,
        physics: const NeverScrollableScrollPhysics(),
        labelStyle: TextStyle(fontSize: 14.w),
        unselectedLabelStyle: TextStyle(fontSize: 14.w),
        dividerHeight: 1,
        indicator: const EasyFixedIndicator(
          height: 3,
          width: 20,
        ),
        labelPadding: EdgeInsets.zero,
        padding: EdgeInsets.zero,
      ),
    );
  }
}
