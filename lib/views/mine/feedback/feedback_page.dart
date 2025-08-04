import 'package:baby_app/components/text_view.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final List<(String title, String content)> list = [
    ('为什么充值不了？', '由于网络问题，请尝试其他的充值渠道或重启app再次会试获取充值链接，如还未解决，请联系客服。'),
    (
      '充值后没到账？',
      '充值到账会有延迟，正常情况到账时间为1小时内，若超过12小时未到账可联系客服为您加紧处理！（在您反馈时需要上传支付成功的截图哦）。'
    ),
    (
      '如何分享给好友？',
      '在分享页面点击【保存图片分享】即可保存图片到相册，要分享时选择相册图片即可；点击【复制分享链接】即可复制文字分享，分享时长按粘贴即可。'
    ),
    ('分享给好友后，没有VIP？', '邀请好友注册后，需查看好友推广码是否有填写为你的分享码，若没有则需手动填写'),
    ('购买会员/金币支付失败？', '使用支付宝支付失败时，请间隔2分钟重试，如果还是不行，可以换种支付方式或者给客服留言。'),
    (
      '如何填写邀请码？',
      '在【我的】页面点击个人头像或者设置即可转页面，然后点击【输入推广码】打开新页面，输入对方的推广码即可（ps：邀请码要注意大小写）。'
    ),
    ('忘记密码，如何找回账号？', '请保存好个人推广码或注册账号，向客服留言反馈为你重置修改。'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('帮助反馈')),
      body: _buildBodyView(),
    );
  }

  _buildBodyView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.verticalSpace,
          TextView(
            text: '常见问题',
            color: COLOR.white.withValues(alpha: 0.8),
            fontSize: 15.w,
            fontWeight: FontWeight.w500,
          ),
          10.verticalSpace,
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return _buildItemView(list[index]);
            },
            separatorBuilder: (context, index) => 20.verticalSpace,
          ),
        ],
      ).marginHorizontal(15.w),
    );
  }

  _buildItemView((String title, String content) item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          text: item.$1,
          color: COLOR.white.withValues(alpha: 0.8),
          fontSize: 13.w,
          fontWeight: FontWeight.w500,
        ),
        TextView(
          text: item.$2,
          color: COLOR.white.withValues(alpha: 0.6),
          fontSize: 13.w,
        ),
      ],
    );
  }
}
