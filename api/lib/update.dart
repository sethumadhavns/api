
import 'package:flutter/material.dart';


String? heading='ENTER THE BUTTON';
class Updateprovider extends ChangeNotifier{
  int _prin=0;
int get prin=>_prin;

 dynamic change(int num){
     _prin=num;
     _prin==1?heading='Years':heading='POPULATION';

   notifyListeners();
}
}