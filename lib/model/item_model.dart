class ItemModel{
  String? itemData;
  DateTime? date;

  ItemModel({this.itemData, this.date});

  ItemModel.fromJson(Map<String, dynamic> json) {
    date= DateTime.parse(json["date"]);
    itemData= json["itemData"] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      "itemData": itemData ?? '',
      "date": date!.toIso8601String(),
    };
  }

}
