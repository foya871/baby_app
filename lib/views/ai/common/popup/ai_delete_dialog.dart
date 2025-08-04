import '../../../../components/popup/dialog/base_confirm_dialog.dart';
import '../ai_record_cell.dart';

class AiDeleteOneDialog extends BaseConfirmDialog {
  AiDeleteOneDialog(AiRecordCellType type, {required super.onConfirm})
      : super(
          titleText: '确定删除本记录',
          cancelText: '取消',
          confirmText: '确定',
          autoBackOnCancel: true,
          autoBackOnConfirm: true,
        );
}

class AiDeleteStatusDialog extends BaseConfirmDialog {
  AiDeleteStatusDialog({required super.onConfirm})
      : super(
          titleText: '确定要删除全部记录',
          cancelText: '取消',
          confirmText: '确定',
          autoBackOnCancel: true,
          autoBackOnConfirm: true,
        );
}
