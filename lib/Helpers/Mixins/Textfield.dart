import 'dart:async';

abstract class Textfield{}
class AddText extends Textfield{
  String data;
  AddText({required this.data});
}
mixin Textfielddata{
  StreamController<Textfield?> fieldcontroller = StreamController<Textfield?>();
  void setfield({required Textfield event}) {
    fieldcontroller.add(event);
  }
  void closemixin() async{
    await fieldcontroller.close();
  }
}