/*
 * @Author: wdz
 * @Date: 2025-07-09 15:27:36
 * @LastEditTime: 2025-07-10 20:03:47
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /baby_app/lib/components/ad/ad_enum.dart
 */
///所有项目通用广告枚举
/// 此次项目   未用到的已注释
/// 已注释的  不要删除   不要删除   不要删除   不要删除   不要删除
/// START("START"), // 启动页 100
/// START_POP_UP("START_POP_UP"), // 启动弹框 200 3个一列的广告
/// SEARCH("SEARCH"), // 搜索页广告 300
/// LONG_VIDEO_PLAY("LONG_VIDEO_PLAY"), // 长视频播放页广告 400
/// TWO_COLUMN_WATERFALL_HORIZONTAL("TWO_COLUMN_WATERFALL_HORIZONTAL"), // 两列瀑布流横版广告 500
/// PLAY_PAGE_THUMBNAIL("PLAY_PAGE_THUMBNAIL"), // 播放页小图 600
/// COMMUNITY_INSERT("COMMUNITY_INSERT"), // 社区插入广告 700
/// TEXT("TEXT"), // 文字广告 800
/// FLOATING_ICON_BOTTOM_RIGHT("FLOATING_ICON_BOTTOM_RIGHT"), // 右下角悬浮图标 900
/// BOTTOM_ICON_TEXT("BOTTOM_ICON_TEXT"), // 底部图标文字广告 1000
/// LONG_VIDEO_PAUSE("LONG_VIDEO_PAUSE"), // 长视频播放页暂停广告  1100
/// NAV_ICON("NAV_ICON"), // 导航站图标广告 1200
/// TOP_BANNER("TOP_BANNER"), // 顶部banner  1300
/// SHORT_VIDEO_LEFT_ICON_TEXT("SHORT_VIDEO_LEFT_ICON_TEXT"), // 短视频左下角图标文字广告 1400
/// SHORT_VIDEO_RIGHT_FLOATING_ICON("SHORT_VIDEO_RIGHT_FLOATING_ICON"), // 短视频右侧悬浮图标  1500
/// SHORT_VIDEO_TOP_ICON("SHORT_VIDEO_TOP_ICON"), // 短视频顶部图标广告 1600
/// LONG_VIDEO_PLAY_ICON("LONG_VIDEO_PLAY_ICON"), // 长视频播放页图标广告 1700
/// TWO_COLUMN_WATERFALL_VERTICAL("TWO_COLUMN_WATERFALL_VERTICAL"), // 两列瀑布流竖版广告 1800
/// VIDEO_COMMENT_TEXT("VIDEO_COMMENT_TEXT"), // 视频评论区文字广告 1900
/// LONG_VIDEO_PLAY_START("LONG_VIDEO_PLAY_START"), // 长视频播放页开头广告 2000
/// LONG_VIDEO_PLAY_POP_UP("LONG_VIDEO_PLAY_POP_UP"), // 长视频播放页弹框广告 2100
/// THREE_COLUMN_WATERFALL_VERTICAL("THREE_COLUMN_WATERFALL_VERTICAL"), // 三列瀑布流竖版广告 2200
/// BUSINESS_PARTNER("BUSINESS_PARTNER"), // 商务合作 2300
/// INDEX_POP_ICON("INDEX_POP_ICON"), // 弹窗九宫格图标  2400
/// CLASSIFY_TOP_ICONS("CLASSIFY_TOP_ICONS"), // 顶部图标广告 2500
/// ONE_COLUMN_WATERFALL_VERTICAL("ONE_COLUMN_WATERFALL_VERTICAL"), // 单列瀑布流横版广告 2600
/// ONE_COLUMN_WATERFALL_VERTICAL(2700, "单列瀑布流横版广告", "710*400"),
enum AdApiType {
  INVALID(""),
  START("START"), // 启动页 100 (750*1624/750*806/ 750*533)
  START_POP_UP("START_POP_UP"), // 启动弹框 200 (660*300)
  INDEX_POP_ICON("INDEX_POP_ICON"), // 弹窗九宫格图标  300 (150*150)
  NAV_ICON("NAV_ICON"), // 导航站图标广告 600 (150*150)
  PLAY_PAGE_THUMBNAIL("PLAY_PAGE_THUMBNAIL"), // 播放页小图 700 (300*60)
  INSERT_IMAGE("INSERT_IMAGE"), // 插入广告 800 (710*200)
  LONG_VIDEO_PLAY_START("LONG_VIDEO_PLAY_START"), // 播放页开头广告 900 (750*460)
  FLOATING_ICON_BOTTOM_RIGHT(
      "FLOATING_ICON_BOTTOM_RIGHT"), // 悬浮图标广告 1500 (150*150)
  LONG_VIDEO_PAUSE("LONG_VIDEO_PAUSE"), // 播放页暂停广告 1700 (320*196)
  INSERT_ICON("INSERT_ICON"), // 插入图标广告 1800 (150*150)
  COMMENT_TEXT("COMMENT_TEXT"), // 评论区广告 1900 (配置最多17个字)
  ;

  final String name;

  const AdApiType(this.name);
}

///广告展示类型
enum AdShowType {
  single("single"), // 单个广告
  multiple("multiple"), // 多个广告
  insert("insert"), // 插入广告
  ;

  final String type;

  const AdShowType(this.type);
}
