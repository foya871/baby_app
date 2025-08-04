import 'package:flutter/widgets.dart';

import 'ad_enum.dart';

class AdInsertView extends StatefulWidget {
  final AdApiType adApiType;
  final bool isShowAdMark;

  const AdInsertView({
    super.key,
    required this.adApiType,
    this.isShowAdMark = true,
  });

  @override
  State<AdInsertView> createState() => _AdInsertViewState();
}

class _AdInsertViewState extends State<AdInsertView> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
