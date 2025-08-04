///购买类型
enum PurTypeEnum {
  vip(2), //VIP
  gold(3), //金币
  ticket(4), //票券
  aiVip(5), //AiVIP
  groupBuy(6), //团购
  ;

  final int type;

  const PurTypeEnum(this.type);
}

///支付类型
enum PayTypeEnum {
  balance(0), //余额
  alipay(1), //支付宝
  wechat(2), //微信
  unionPay(3), //云闪付
  unKnown(-1), //未知支付方式
  ;

  final int type;

  const PayTypeEnum(this.type);
}

///支付通道来源
enum SourceTypeEnum {
  platformSelf(0), //本平台
  ;

  final int type;

  const SourceTypeEnum(this.type);
}
