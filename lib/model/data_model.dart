class DataModel{
  String? itemUid;
  DateTime? date;
  List<ItemModel>? itemData = [];


  DataModel({this.itemUid, this.date, this.itemData});

  DataModel.fromJson(Map<String, dynamic> json) {

    date= DateTime.parse(json["date"]);
    itemUid= json["itemUid"] ?? '';

    itemData = [];
    List dataList = json['itemData'] ?? [] ;
    itemData = dataList.map((e) => ItemModel.fromJson(e)).toList();

  }

  Map<String, dynamic> toJson() {
    return {
      "itemUid": itemUid ?? '',
      "date": date!.toIso8601String(),
      "itemData" : [],
    };
  }
}

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
