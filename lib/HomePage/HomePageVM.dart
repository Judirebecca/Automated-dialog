import 'package:automateddialog/HomePage/HomePageModel.dart';
import 'package:flutter/material.dart';
import '../Helpers/AppNavigations/NavigationMixin.dart';
import '../Helpers/Mixins/Popup.dart';


// Create a class HomePageVM that extends the MyHomePageModel
class HomePageVM extends HomePageModel {

  /* Inside the method textinput set the value of the variable givenuserinput to the currenttext.
  Add the givenuserinput to the List add and set the data to the variable value in th method setnamelist*/

    void textinput({required String givenuserinput}) {
    setdata(currenttext: givenuserinput);
    value.add(givenuserinput);
    setnamelist(value: value);
    debugPrint("####################################$givenuserinput#############################");
  }

  // Add the NavigatorPop to the navigation stream using the method addPopTodialog
  void addPopTodialog() {
    navigationStream.add(NavigatorPop()); 
  }

  Future<void> getinputfromuser({required int index}) async{
    await Future.delayed(const Duration(seconds: 3));
    setindex(indextoshow: index);
    setfield(event:  AddText(data:[index, "showpopup"]));
    await Future.delayed(const Duration(seconds: 3));
    navigationStream.add(NavigatorPop());
    }
  }
