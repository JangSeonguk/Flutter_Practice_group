import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: CalculatorTest(),
    );
  }
}

class CalculatorTest extends StatefulWidget {
  @override
  State<CalculatorTest> createState() => _CalculatorTestState();
}

class _CalculatorTestState extends State<CalculatorTest> {
  String sum = '';
  var _iconChange;

  TextEditingController value1 = TextEditingController();
  TextEditingController value2 = TextEditingController();

  List _buttonList = ['더하기','빼기','곱하기','나누기'];
  List<DropdownMenuItem<String>> _dropDownMenuItems = new List.empty(growable:true);
  String? _buttonText;

  void initState(){
    super.initState();
    for(var item in _buttonList){
      _dropDownMenuItems.add(DropdownMenuItem(value: item,child: Text(item)));
    }
    _buttonText = _dropDownMenuItems[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('결과 : $sum',style: TextStyle(fontSize: 20),),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              controller: value1,
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            controller: value2,
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  var value1Parse = int.parse(value1.value.text);
                  var value2Parse = int.parse(value2.value.text);
                  var result;

                  if(_buttonText == '더하기'){
                    result = value1Parse +value2Parse;
                  }
                  else if(_buttonText =='빼기') {
                    result = value1Parse - value2Parse;
                  }
                  else if(_buttonText =='곱하') {
                    result = value1Parse *value2Parse;
                  }
                  else result = value1Parse/value2Parse;
                  sum = '$result';
                });
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(_iconChange),
                Text(_buttonText!),
              ])),
          DropdownButton(items: _dropDownMenuItems,onChanged: (String? value){
            setState(() {
              _buttonText = value;
              if(_buttonText == '더하기') _iconChange = Icons.add;
              else if(_buttonText =='빼기') _iconChange = Icons.star;
              else if(_buttonText =='곱하') _iconChange = Icons.face;
              else _iconChange = Icons.circle;

            });
          },value: _buttonText),
        ]),
      ),
    );
  }
}
