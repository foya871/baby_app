/*
 * @Author: chentuan guotengda7204@gmail.com
 * @Date: 2025-03-19 18:11:40
 * @LastEditors: chentuan guotengda7204@gmail.com
 * @LastEditTime: 2025-03-21 17:02:59
 * @FilePath: /dou_yin_jie_mi_app/lib/components/swipe_cards/swipe_info.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
enum SwipeDirection { left, right, none }

class SwipeInfo {
  final int cardIndex;
  final SwipeDirection direction;
  final DateTime timestamp = DateTime.now();

  SwipeInfo(
    this.cardIndex,
    this.direction, {
    DateTime? timestamp,
  });

  @override
  String toString() => 'Swipe[$cardIndex] $direction @ $timestamp';
}
