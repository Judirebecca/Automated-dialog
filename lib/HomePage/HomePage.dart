import 'package:automateddialog/Helpers/AppNavigations/NavigationHelpers.dart';
import 'package:automateddialog/HomePage/HomePageVM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../Helpers/AppNavigations/NavigationMixin.dart';
import '../Helpers/Mixins/Textfield.dart';


// Create a class MyHomePage that extends the StatefulWidget
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  // Create an instance _instance for the class HomePageVM
  final HomePageVM _instance = HomePageVM();

  // Create an instance _controller for the TextEditingController
  final TextEditingController _controller = TextEditingController();

  /* Create an init State */
  @override
  void initState() {

    //Invoke the overriden method initstate
    super.initState();
    _instance.fieldcontroller.stream.listen((event) {
      if(event is AddText){
        switch (event.data) {
          case "showpopup": 
            popUpuserInput( _instance.index);
            break;
        }
        _controller.text = event.data;
        _controller.selection = TextSelection.collapsed(offset: _controller.text.length);
      }
    });

    // In the init state listen to the stream if NavigatorPop event in received 
    _instance.navigationStream.stream.listen((event) {
      if (event is NavigatorPop) {
        [context.pop(data: event.data, checkMounted: event.checkMounted)];
      }
    }
    );
  }

  // Create a method popUpuserInput
  void popUpuserInput(int index) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
        
          content: Container(
            width: 200,
            height: 200,
            color: Colors.amber,

            // Inside the alert box display the particular data in the index of the list value
            child: Text(_instance.value[index]),
          ),
          actions: [
            ElevatedButton(

                // When pressed, trigger the method addPopTodialog
                onPressed: () => _instance.addPopTodialog(),
                child: const Text("Cancel"))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Text form field")),
        body: ListView(children: [
          Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: "Enter the name"),
                // To the controller parameter pass the instance of the textFormField
                controller: _controller,
              ),
              ElevatedButton(
                  onPressed: () {
                    // The button is used to pass the text in the controller using the textinput method's constructor
                    _instance.textinput(givenuserinput: _controller.text);
                  },
                  child: const Text("Add name")),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 30),
                child: Observer(
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),

                          // Inside the builder specify the number of items as the List value's length
                          itemCount: _instance.value.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Display the element present in that paticular index of the list value
                               Text(_instance.value[index]),
                                const SizedBox(
                                  width: 200,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      
                                      // On press pass the index of the data to the method popUpuserInput so that it 
                                      // displays that particular data of text input field's controller in the dialog box
                                      _instance.getinputfromuser(index: index);
                                    },
                                    child: const Text("Show")),
                              ],
                            );
                          }),
                    );
                  },
                ),
              )
            ],
          ),
        ]));
  }
}
