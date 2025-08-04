import 'package:baby_app/components/base_page/base_loading_widget.dart';
import 'package:baby_app/components/circle_image.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/model/comment/comment_send_model.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/utils/color.dart';
import 'package:baby_app/utils/utils.dart';
import 'package:baby_app/views/community/comment/comment_list.dart';
import 'package:baby_app/views/community/detail/community_detail_page_controller.dart';
import 'package:baby_app/views/community/detail/community_info_cell.dart';
import 'package:baby_app/views/community/widget/community_ad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

class CommunityDetailPage extends GetView<CommunityDetailPageController> {
  const CommunityDetailPage({super.key});

  AppBar _buildAppBar() => AppBar(
        shadowColor: const Color.fromRGBO(0, 0, 0, 0),
        iconTheme: const IconThemeData(color: COLOR.white),
        title: Obx(() {
          return Row(
            children: <Widget>[
              CircleImage.network(
                controller.community.value.logo ?? '',
                size: 40.w,
              ),
              Text(
                controller.community.value.nickName ?? '',
                style: TextStyle(
                  color: COLOR.white,
                  fontSize: 15.w,
                  fontWeight: FontWeight.w500,
                ),
              ).marginOnly(left: 5.w),
            ],
          );
        }),
        centerTitle: false,
        titleSpacing: 0,
        leadingWidth: 40.w,
        actions: [
          Obx(() {
            return (controller.community.value.dynamicId != 0)
                ? Image.asset(
                    controller.community.value.attention == true
                        ? AppImagePath.community_attention
                        : AppImagePath.community_attention_no,
                    width: 62.w,
                    height: 28.w,
                  ).marginOnly(left: 10.w, right: 10.w).onOpaqueTap(() {
                    controller.communityAttention(
                        controller.community.value.userId ?? 0,
                        controller.community.value.attention ?? false);
                  })
                : const SizedBox.shrink();
          }),
        ],
      );

  _buildTop() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            controller.community.value.title ?? '',
            style: TextStyle(
              color: COLOR.white,
              fontSize: 13.w,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '${Utils.numFmt(controller.community.value.fakeWatchTimes ?? 0)}浏览',
                style: TextStyle(
                  color: COLOR.color_999999,
                  fontSize: 12.w,
                ),
              ),
              Text(
                Utils.dateFmt(
                  controller.community.value.checkAt ?? '',
                  ['yyyy', '.', 'mm', '.', 'dd'],
                ),
                style: TextStyle(
                  color: COLOR.color_999999,
                  fontSize: 12.w,
                ),
              ),
            ],
          ).marginOnly(top: 7.w),
        ],
      ).sliver;
    });
  }

  _buildContent() {
    return Obx(() {
      return SliverPadding(
        padding: EdgeInsets.only(top: 10.w),
        sliver: SliverList.builder(
            itemCount: controller.communityInfoList.length,
            itemBuilder: (context, index) {
              return CommunityInfoCell(
                model: controller.communityInfoList[index],
                pictures: controller.pictures,
                community: controller.community.value,
              );
            }),
      );
    });
  }

  _buildBottom() {
    return ValueListenableBuilder(
      valueListenable: controller.showComm,
      builder: (context, value, child) {
        return Container(
          padding:
              EdgeInsets.only(left: 10.w, top: 7.w, right: 10.w, bottom: 7.w),
          color: COLOR.transparent,
          child: Row(
            children: <Widget>[
              Visibility(
                visible: !value,
                maintainState: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 306.w,
                      height: 36.w,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      decoration: BoxDecoration(
                        color: COLOR.white_10,
                        borderRadius: BorderRadius.circular(18.w),
                      ),
                      child: Text(
                        '写下你的评论…',
                        style: TextStyle(
                          color: COLOR.white_60,
                          fontSize: 13.w,
                        ),
                      ),
                    ).onOpaqueTap(() {
                      controller.focusNode.requestFocus();
                    }),
                    Image.asset(
                      AppImagePath.community_comment_send,
                      width: 30.w,
                      height: 30.w,
                    ).marginOnly(left: 15.w),
                  ],
                ),
              ),
              Visibility(
                visible: value,
                maintainState: true,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 280.w,
                      height: 70.w,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: COLOR.white_10,
                        borderRadius: BorderRadius.circular(6.w),
                      ),
                      child: ValueListenableBuilder(
                        valueListenable: controller.defaultText,
                        builder: (context, value, child) {
                          return TextField(
                            focusNode: controller.focusNode,
                            maxLines: 5,
                            style: TextStyle(
                              color: COLOR.white,
                              fontSize: 13.w,
                            ),
                            controller: controller.commTextController,
                            onSubmitted: (value) {
                              controller.handleComment();
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.w),
                              hintText: value,
                              hintStyle: TextStyle(
                                color: COLOR.white_60,
                                fontSize: 13.w,
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(0, 0, 0, 0)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(0, 0, 0, 0)),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      width: 56.w,
                      height: 32.w,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        color: COLOR.color_009fe8,
                        borderRadius: BorderRadius.circular(16.w),
                      ),
                      child: Center(
                        child: Text(
                          '发布',
                          style: TextStyle(
                            color: COLOR.white,
                            fontSize: 14.w,
                          ),
                        ),
                      ).onOpaqueTap(() {
                        controller.handleComment();
                      }),
                    ).marginOnly(left: 10.w, top: 30.w),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        FocusManager.instance.primaryFocus?.unfocus();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SafeArea(
            bottom: true,
            child: Stack(
              children: <Widget>[
                Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Expanded(
                      child: CustomScrollView(
                        slivers: <Widget>[
                          _buildTop(),
                          _buildContent(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Obx(() {
                                    return Row(
                                      children: <Widget>[
                                        Image.asset(
                                          controller.community.value.isLike ==
                                                  true
                                              ? AppImagePath.community_praise
                                              : AppImagePath
                                                  .community_praise_no,
                                          width: 20.w,
                                          height: 20.w,
                                        ),
                                        Text(
                                          Utils.numFmtCh(controller
                                                  .community.value.fakeLikes ??
                                              0),
                                          style: TextStyle(
                                            color: COLOR.white_50,
                                            fontSize: 12.w,
                                          ),
                                        ).marginOnly(left: 2.w),
                                      ],
                                    ).onOpaqueTap(() {
                                      controller.communityPraise(
                                          controller
                                                  .community.value.dynamicId ??
                                              0,
                                          controller.community.value.isLike ??
                                              false);
                                    });
                                  }),
                                  Obx(() {
                                    return Row(
                                      children: <Widget>[
                                        Image.asset(
                                          controller.community.value
                                                      .isFavorite ==
                                                  true
                                              ? AppImagePath.community_collect
                                              : AppImagePath
                                                  .community_collect_no,
                                          width: 20.w,
                                          height: 20.w,
                                        ),
                                        Text(
                                          Utils.numFmtCh(controller.community
                                                  .value.fakeFavorites ??
                                              0),
                                          style: TextStyle(
                                            color: COLOR.white_50,
                                            fontSize: 12.w,
                                          ),
                                        ).marginOnly(left: 2.w),
                                      ],
                                    ).onOpaqueTap(() {
                                      controller.communityFavorite(
                                          controller
                                                  .community.value.dynamicId ??
                                              0,
                                          controller
                                                  .community.value.isFavorite ??
                                              false);
                                    });
                                  }),
                                  Row(
                                    children: <Widget>[
                                      Image.asset(
                                        AppImagePath.community_share,
                                        width: 20.w,
                                        height: 20.w,
                                      ),
                                      Text(
                                        '分享',
                                        style: TextStyle(
                                          color: COLOR.white_50,
                                          fontSize: 12.w,
                                        ),
                                      ).marginOnly(left: 2.w),
                                    ],
                                  ).onOpaqueTap(() {
                                    Get.toShare();
                                  }),
                                ],
                              ).marginOnly(left: 45.w, right: 45.w),
                              Divider(
                                color: COLOR.white_10,
                                thickness: 1.w,
                                height: 0.w,
                              ).marginOnly(top: 10.w),
                              Obx(() {
                                return ((controller
                                                .community01.value.dynamicId !=
                                            0) ||
                                        (controller
                                                .community02.value.dynamicId !=
                                            0))
                                    ? Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Expanded(
                                                child: controller.community01
                                                            .value.dynamicId !=
                                                        0
                                                    ? Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            '上一篇',
                                                            style: TextStyle(
                                                              color:
                                                                  COLOR.white,
                                                              fontSize: 15.w,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          Text(
                                                            controller
                                                                    .community01
                                                                    .value
                                                                    .title ??
                                                                '',
                                                            style: TextStyle(
                                                              color: COLOR
                                                                  .white_60,
                                                              fontSize: 13.w,
                                                              height: 1.5,
                                                            ),
                                                          ).marginOnly(
                                                              top: 8.w),
                                                        ],
                                                      ).onOpaqueTap(() {
                                                        controller.refreshWithNewId(
                                                            controller
                                                                    .community01
                                                                    .value
                                                                    .dynamicId ??
                                                                0);
                                                      })
                                                    : const SizedBox.shrink(),
                                              ),
                                              Expanded(
                                                child: controller.community02
                                                            .value.dynamicId !=
                                                        0
                                                    ? Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            '下一篇',
                                                            style: TextStyle(
                                                              color:
                                                                  COLOR.white,
                                                              fontSize: 15.w,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          Text(
                                                            controller
                                                                    .community02
                                                                    .value
                                                                    .title ??
                                                                '',
                                                            style: TextStyle(
                                                              color: COLOR
                                                                  .white_60,
                                                              fontSize: 13.w,
                                                              height: 1.5,
                                                            ),
                                                          ).marginOnly(
                                                              top: 8.w),
                                                        ],
                                                      ).onOpaqueTap(() {
                                                        controller.refreshWithNewId(
                                                            controller
                                                                    .community02
                                                                    .value
                                                                    .dynamicId ??
                                                                0);
                                                      })
                                                    : const SizedBox.shrink(),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: COLOR.white_10,
                                            thickness: 1.w,
                                            height: 0.w,
                                          ).marginOnly(top: 10.w),
                                        ],
                                      ).marginOnly(top: 10.w)
                                    : const SizedBox.shrink();
                              }),
                              if (controller.ads.isNotEmpty)
                                Column(
                                  children: <Widget>[
                                    CommunityAd(ads: controller.ads),
                                    Divider(
                                      color: COLOR.white_10,
                                      thickness: 1.w,
                                      height: 0.w,
                                    ).marginOnly(top: 10.w),
                                  ],
                                ).marginOnly(top: 10.w),
                              Obx(() {
                                return Text(
                                  '评论 (${controller.community.value.commentNum ?? 0})',
                                  style: TextStyle(
                                    color: COLOR.white,
                                    fontSize: 15.w,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ).marginOnly(top: 20.w);
                              }),
                            ],
                          ).marginOnly(top: 5.w, bottom: 10.w).sliver,
                          Obx(() {
                            return CommentList(
                              dynamicId: controller.dynamicId.value,
                              reply: (CommentSendModel v, String nick) {
                                controller.defaultText.value = '回复@$nick';
                                controller.params.value = v;
                                controller.focusNode.requestFocus();
                              },
                            );
                          }),
                        ],
                      ).marginOnly(left: 10.w, right: 10.w).onOpaqueTap(() {
                        FocusManager.instance.primaryFocus?.unfocus();
                      }),
                    ),
                    _buildBottom(),
                  ],
                ),
                Obx(() {
                  return controller.community.value.dynamicId == 0
                      ? Container(
                          color: COLOR.themColor,
                          child: const BaseLoadingWidget(),
                        )
                      : const SizedBox.shrink();
                }),
              ],
            )),
      ),
    );
  }
}
