import 'dart:async';

abstract class Popup{}
class AddText extends Popup{
  List<dynamic> data;
  AddText({required this.data});
}
mixin Popupdata{
  StreamController<Popup?> popupcontroller = StreamController<Popup?>();
  void setfield({required Popup event}) {
    popupcontroller.add(event);
  }
  void closemixin() async{
    await popupcontroller.close();
  }
}