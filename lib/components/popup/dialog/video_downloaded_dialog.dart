import 'package:baby_app/components/popup/dialog/base_confirm_dialog.dart';

class VideoDownloadedDialog extends BaseConfirmDialog {
  VideoDownloadedDialog({required super.onConfirm})
      : super(
          titleText: '温馨提示',
          descText: '视频已下载,是否重新下载?',
          cancelText: '取消',
          confirmText: '重新下载',
          autoBackOnCancel: true,
          autoBackOnConfirm: true,
        );
}
