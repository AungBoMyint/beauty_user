import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var textStyleGrey = TextStyle(
  color: Colors.grey,
);
var textStyleBold = TextStyle(
  fontWeight: FontWeight.bold,
);
 Color get disabled {
    return Color(0xff212121);
  }
   Color get textColor {
    return Colors.grey[800]!;
  }

class Input{
  Map<String,TextEditingController> input;
  Input({required this.input});

  String? validateInput(String? data){
    if(data == null || data.isEmpty){
      return "Can't be Empty.";
    }else{
      return null;
    }
  }
}

const appBarTitleStyle = TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            wordSpacing: 2,
            letterSpacing: 2,
          );

enum SortPrice{
  lowToHigh,
  highToLow,
  none,
}
