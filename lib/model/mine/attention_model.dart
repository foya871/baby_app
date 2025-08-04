class AttentionModel {
  bool? attention;

  AttentionModel({
    this.attention,
  });

  factory AttentionModel.fromJson(Map<String, dynamic> json) => AttentionModel(
        attention: json["attention"],
      );

  Map<String, dynamic> toJson() => {
        "attention": attention,
      };
}
