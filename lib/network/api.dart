import 'package:aitask/export_feature.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Api{
  static FirebaseFirestore db = FirebaseFirestore.instance;
  static Future<dynamic> setData({DataModel? dataModel,List<ItemModel>? itemList }) async {
    String? docUid;
    try {
      DocumentReference doc = db.collection(CollectionsFireStoreKeys.DATA).doc();
      docUid = doc.id;
      dataModel!.itemUid = docUid;
      await doc.set(dataModel.toJson()).then((value) => {
        itemList!.forEach((element) async {
              ItemModel? itemModel = element;
              await db
                  .collection(CollectionsFireStoreKeys.DATA)
                  .doc(docUid)
                  .update({
                'itemData': FieldValue.arrayUnion([itemModel.toJson()])
              });
            })
          });
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e.toString());
    }
  }
  static Future<dynamic> loadData() async {
    List<DataModel>? dataList = [];
    try {
       QuerySnapshot querySnapshot = await db.collection(CollectionsFireStoreKeys.DATA).get();
       dataList = querySnapshot.docs.map((e) => DataModel.fromJson(e.data() as Map<String,dynamic>)).toList();
       if (dataList.isNotEmpty) {dataList.sort((a, b) => b.date!.compareTo(a.date!));}

      return dataList;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e.toString());
    }
  }
  static Future<dynamic> deleteData({String? itemUid }) async {
    try {
      DocumentReference doc = db.collection(CollectionsFireStoreKeys.DATA).doc(itemUid);
      await doc.delete();
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e.toString());
    }
  }

}
