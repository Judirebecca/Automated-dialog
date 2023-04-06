

// create a class MyHomePageModel that extends the Navigation mixin and textfielddata mixin
import 'package:mobx/mobx.dart';
import '../Helpers/AppNavigations/NavigationMixin.dart';
import '../Helpers/Mixins/Textfield.dart';
part 'HomePageModel.g.dart';

class HomePageModel = _HomePageModelBase with _$HomePageModel, NavigationMixin,Textfielddata;

abstract class _HomePageModelBase with Store {

  // Declare a variable List datatype that accepts elements with string datatype and initialize it with an empty string
  @observable
  List<String> value = [];

  // Reassign the data of the variable value
  @action
  void setnamelist({required List<String> value}) {
    this.value = [];
    this.value = value;
  }

  // Declare a variable textdata with string datatype and initialize its value with an empty string
  @observable
  String textdata = "";

  // Set the value of the textdata to the currenttext using the method setdata
  @action
  void setdata({required String currenttext}) {
    textdata = currenttext;
  }

  @observable
  int index = 0;

  @action
  void setindex({required int indextoshow})
  {
    indextoshow=index;
  }

}
