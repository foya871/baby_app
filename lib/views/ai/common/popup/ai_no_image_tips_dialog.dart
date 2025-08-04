import '../../../../components/popup/dialog/base_confirm_dialog.dart';

class AiNoImageTipsDialog extends BaseConfirmDialog {
  AiNoImageTipsDialog()
      : super(
          titleText: '温馨提示',
          descText: '先上传人脸照片才可以使用',
          cancelText: '取消',
          confirmText: '确定',
          autoBackOnCancel: true,
          autoBackOnConfirm: true,
        );
}

class AiNoStencilImageTipsDialog extends BaseConfirmDialog {
  AiNoStencilImageTipsDialog()
      : super(
          titleText: '温馨提示',
          descText: '请上传模版，才可以使用哦',
          cancelText: '取消',
          confirmText: '确定',
          autoBackOnCancel: true,
          autoBackOnConfirm: true,
        );
}
