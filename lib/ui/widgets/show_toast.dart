import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToastAboutAdded(){
  return FToast().showToast(
      child: Container(
        child: Text("Added successfully!"),
      ),
  );
}