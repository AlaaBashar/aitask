import '../export_feature.dart';

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

