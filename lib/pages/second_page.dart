import 'package:aitask/export_feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SecondPage extends StatefulWidget{
  final String? dataType;
  final int? number;
  const SecondPage({Key? key, this.dataType, this.number}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List<ItemModel>? dataList = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    loadData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: SingleChildScrollView(

        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    var dataController = TextEditingController();
                    if(widget.dataType == 'Text'){
                      return TextFieldApp(
                        type: TextInputType.text,
                        controller: dataController,
                        hintText: 'Insert ${widget.dataType!} data',
                        inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'^[\s]+'))],
                        suffixIcon: IconButton(icon: const Icon(Icons.clear), onPressed: ()=>dataController.clear(),),
                        isRTL: false,
                        validator: (value) {
                          ItemModel itemModel = ItemModel();
                          itemModel..date = DateTime.now()
                          ..itemData = dataController.text;
                          dataList!.add(itemModel);
                          if (value!.isEmpty) {
                            ShowToastSnackBar.displayToast(message: 'This Field is required');
                            return '';
                          }
                          return null;
                        },
                      );
                    }
                    else if(widget.dataType == 'Numbers'){
                      return TextFieldApp(
                        controller: dataController,
                        type: TextInputType.number,
                        hintText: 'Insert ${widget.dataType!} data',
                        inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'^[\s]+'))],
                        suffixIcon: IconButton(icon: const Icon(Icons.clear), onPressed: ()=>dataController.clear(),),
                        isRTL: false,
                        validator: (value) {
                          ItemModel itemModel = ItemModel();
                          itemModel..date = DateTime.now()
                            ..itemData = dataController.text;
                          dataList!.add(itemModel);
                          if (value!.isEmpty) {
                            ShowToastSnackBar.displayToast(message: 'This Field is required');
                            return '';
                          }
                          return null;
                        },
                      );
                    }
                    else if(widget.dataType == 'Date'){
                      return TextFieldApp(
                        controller: dataController,
                        readOnly: true,
                        showCursor: true,
                        hintText: 'Insert ${widget.dataType!} data',
                        inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'^[\s]+'))],
                        suffixIcon: IconButton(icon: const Icon(Icons.clear), onPressed: ()=>dataController.clear(),),
                        onTap: ()async{
                          String? date = await DateTimePicker.datePicker(context: context);
                          dataController.text = date ??DateTimePicker.dateFormat(date: DateTime.now());
                        },
                        isRTL: false,
                        validator: (value) {
                          ItemModel itemModel = ItemModel();
                          itemModel..date = DateTime.now()
                            ..itemData = dataController.text;
                          dataList!.add(itemModel);
                          if (value!.isEmpty) {
                            ShowToastSnackBar.displayToast(message: 'This Field is required');
                            return '';
                          }
                          return null;
                        },
                      );
                    }
                    return const SizedBox(width: 10.0,);

                  },
                  separatorBuilder: (context,index) => const SizedBox(height: 10.0,),
                  itemCount: widget.number!,
                ),
                const SizedBox(height: 20.0,),
                DefaultButtonWidget(text: 'Save', onPressed:onSave,color: Colors.blue,height: 35.0,),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onSave() async{
    if (!_formKey.currentState!.validate()) {return;}
    for( int x = 0 ; x<=dataList!.length -1 ;x++) {
      dataList![x];
    }
    DataModel dataModel = DataModel();
    dataModel.date =DateTime.now() ;
    await Api.setData(dataModel: dataModel,itemList: dataList);
    openNewPage(context, const ThirdPage());


  }





  Future<void> loadData()async{
    await Api.loadData();

  }
}
