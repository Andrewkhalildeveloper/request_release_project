
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class MobileScanner{
  static String codeRes ='';
  static Future<void> scan()async{
    try{
         String code =await FlutterBarcodeScanner.scanBarcode("#67bfbc","Cancel",
         true,ScanMode.QR
      );
         codeRes=code;
    }catch(e){
      print(e.toString());
    }
  }
  static showCode(){
    if(codeRes ==''){
      return const Text('No data here',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),);
    }else{
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          BarcodeWidget(data: codeRes, barcode: Barcode.qrCode()),
          const SizedBox(height: 10,),
          Text(codeRes,style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),)
        ],
      );
    }
  }
}