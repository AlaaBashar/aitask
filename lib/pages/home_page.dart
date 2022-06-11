import 'package:aitask/export_feature.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  var numberController = TextEditingController();
  String? selectedValue='Text';
  final _formKey = GlobalKey<FormState>();

  List<DropdownMenuItem<String>> get dropdownItems =>menuItems;

  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(child: Text("Text"),value: "Text"),
    const DropdownMenuItem(child: Text("Numbers"),value: "Numbers"),
    const DropdownMenuItem(child: Text("Date"),value: "Date"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Form(
        key:_formKey ,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
            Row(
              children: [
                  Expanded(
                      child: TextFieldApp(
                          controller: numberController,
                          hintText: 'Number of Fields',
                          isRTL: false,
                          type: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            ShowToastSnackBar.displayToast(message: 'Number of item Must Be Not Empty');
                            return '';
                          }
                          return null;
                        },

                      )),
                  const SizedBox(width: 4.0,),
                DropdownButton(
                    items: dropdownItems,
                    value: selectedValue,
                    onChanged: (String? newValue){
                      setState(() {
                        selectedValue = newValue!;
                        debugPrint('$selectedValue');
                      });
                    },
                  ),
              ],
            ),
            const SizedBox(height: 20.0,),
            DefaultButtonWidget(text: 'Next', onPressed:onNext,color: Colors.blue,height: 35.0,),

          ],),
        ),
      ),
    );
  }

  Future<void> onNext()async{
    if (!_formKey.currentState!.validate()) {return;}

   openNewPage(context,  SecondPage(number:int.parse(numberController.text),dataType: selectedValue,));

  }
}
