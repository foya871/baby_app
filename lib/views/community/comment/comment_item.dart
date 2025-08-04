import 'package:baby_app/components/circle_image.dart';
import 'package:baby_app/components/diolog/loading/loading_view.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/http/api/api.dart';
import 'package:baby_app/model/comment/comment_dynamic_model.dart';
import 'package:baby_app/model/comment/comment_send_model.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/utils/utils.dart';
import 'package:baby_app/views/community/comment/comment_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommentItem extends StatefulWidget {
  const CommentItem({
    super.key,
    required this.comment,
    required this.dynamicId,
    required this.reply,
  });

  final CommentDynamicModel comment;
  final int dynamicId;
  final Function reply;

  @override
  State createState() => _CommentItem();
}

class _CommentItem extends State<CommentItem> {
  var params = CommentSendModel.fromJson({});
  var model = CommentDynamicModel.fromJson({});
  var total = 0;
  var show = false;

  Future _initListData(int parentId) async {
    List<CommentDynamicModel>? result = await LoadingView.singleton.wrap(
      context: context,
      asyncFunction: () async {
        return await Api.getCommentList(
          dynamicId: widget.dynamicId,
          parentId: parentId,
          page: 1,
          pageSize: 10,
        );
      },
    );

    result ??= [];
    setState(() {
      if (result != null && result.isNotEmpty) {
        model = result[0];
        total = result.length;
        show = true;
        widget.comment.comments = result;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var vipType = widget.comment.vipType ?? 0;
    var replyNum = widget.comment.replyNum ?? 0;
    if (widget.comment.comments != null &&
        widget.comment.comments!.isNotEmpty) {
      model = widget.comment.comments![0];
      total = widget.comment.comments!.length;
      show = true;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleImage.network(
              widget.comment.logo ?? '',
              size: 36.w,
            ),
            Row(
              children: <Widget>[
                Text(
                  widget.comment.nickName ?? '',
                  style: TextStyle(
                    color: COLOR.white,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ).marginOnly(left: 8.w),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.comment.content ?? '',
              style: TextStyle(
                color: COLOR.white_60,
                fontSize: 14.w,
                height: 1.5,
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  height: 26.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(12.w),
                  ),
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Text(
                          replyNum > 0 ? '$replyNum回复' : '回复',
                          style: TextStyle(
                            color: COLOR.white_60,
                            fontSize: 12.w,
                          ),
                        ),
                        Image.asset(
                          AppImagePath.community_arrow,
                          width: 12.w,
                          height: 12.w,
                        ),
                      ],
                    ).marginOnly(left: 8.w, right: 8.w),
                  ).onOpaqueTap(() {
                    if (replyNum > 0) {
                      if (!show) {
                        _initListData(widget.comment.commentId ?? 0);
                      }
                    } else {
                      params = CommentSendModel.fromJson({
                        'parentId': widget.comment.commentId,
                        'topId': widget.comment.commentId,
                      });
                      widget.reply(params, widget.comment.nickName ?? '');
                    }
                  }),
                ),
                Text(
                  Utils.dateAgo(widget.comment.createdAt ?? ''),
                  style: TextStyle(
                    color: COLOR.white_60,
                    fontSize: 12.w,
                  ),
                ).marginOnly(left: 9.w),
              ],
            ).marginOnly(top: 8.w),
            if (total > 0)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(6.w),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CircleImage.network(
                          model.logo ?? '',
                          size: 24.w,
                        ),
                        Text(
                          model.nickName ?? '',
                          style: TextStyle(
                            color: COLOR.white,
                            fontSize: 14.w,
                          ),
                        ).marginOnly(left: 10.w),
                      ],
                    ),
                    Text(
                      '回复 ${widget.comment.nickName}：${model.content}',
                      style: TextStyle(
                        color: COLOR.white_60,
                        fontSize: 14.w,
                        height: 1.5,
                      ),
                    ).marginOnly(left: 24.w, top: 8.w),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.w),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '展开全部$total条回复',
                            style: TextStyle(
                              color: COLOR.white,
                              fontSize: 13.w,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Image.asset(
                            AppImagePath.community_comment_arrow,
                            width: 16.w,
                            height: 16.w,
                          ),
                        ],
                      ).onOpaqueTap(() {
                        CommentDialog(
                          widget.dynamicId ?? 0,
                          widget.comment.commentId ?? 0,
                          widget.comment.nickName ?? '',
                        ).show();
                      }),
                    ),
                  ],
                ).marginOnly(left: 10.w, top: 10.w, right: 10.w),
              ).marginOnly(top: 10.w),
          ],
        ).marginOnly(top: 4.w, left: 44.w),
      ],
    );
  }
}
