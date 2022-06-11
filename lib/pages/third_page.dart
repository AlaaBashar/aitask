import 'package:aitask/export_feature.dart';
import 'package:flutter/material.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({Key? key,}) : super(key: key);
  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
   List<DataModel>? dataList = [];
   @override
  void initState() {
     loadData();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Third Page'),
      actions: [
          InkWell(
            onTap: ()=>openNewPage(context, const HomePage(), popPreviousPages: true),
            child: const Center(
              child:  Text('Create new form'),
            ),
          ),
          const SizedBox(width: 20.0,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:dataList != null?
        ListView.builder(
          shrinkWrap: true,
          itemCount:dataList!.length,
          itemBuilder: (context, index) {
            DataModel dataModel = dataList![index];
            return Card(
              child: Column(
                children: [
                  Row(
                    children: [
                            Expanded(
                                child: Align(
                                  alignment: AlignmentDirectional.center,
                                    child: Text(
                                        dataFormat(date: dataModel.date)))),
                            InkWell(
                        onTap: ()=>onClearItem(itemUid: dataModel.itemUid,model:dataModel,),
                        child: const Icon(Icons.clear),
                      ),

                    ],
                  ),
                  const SizedBox(height: 8.0,),

                  loadItems(dataModel.itemData,dataModel.itemUid),
                ],
              ),
            );
          },) : const Center(child: Text('No data...')),
      ),
    );
  }

  Widget loadItems(List<ItemModel>? item,String? itemUId){
    return ListView.builder(
      shrinkWrap: true,
        itemCount: item!.length,
        itemBuilder: (context, index) {
          ItemModel? itemModel = item[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text('item: ${itemModel.itemData}'),
        ],
      ),
          );




    });
  }

  Future<void> onClearItem({String? itemUid,DataModel? model})async{
     dataList!.removeWhere((element) => element.itemUid == model!.itemUid);
     await Api.deleteData(itemUid: itemUid);
     setState(() {});
  }

  Future<void> loadData()async{
    dataList = await Api.loadData();
    setState(() {});
  }
}


