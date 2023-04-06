import 'package:automateddialog/Helpers/AppNavigations/NavigationHelpers.dart';
import 'package:automateddialog/HomePage/HomePageVM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../Helpers/AppNavigations/NavigationMixin.dart';
import '../Helpers/Mixins/Popup.dart';

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
    _instance.popupcontroller.stream.listen((event) {
      if (event is AddText) {
        switch (event.data[1]) {
          case "showpopup":
            popUpuserInput(event.data[0]);
            break;
        }
        _controller.selection =
            TextSelection.collapsed(offset: _controller.text.length);
      }
    });
    // In the init state listen to the stream if NavigatorPop event in received
    _instance.navigationStream.stream.listen((event) {
      if (event is NavigatorPop) {
        [context.pop(data: event.data, checkMounted: event.checkMounted)];
      }
    });
  }

  // Create a method popUpuserInput
  void popUpuserInput(int index) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            width: 200,
            height: 30,

            // Inside the alert box display the particular data in the index of the list value
            child: Text(_instance.value[index]),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Text form field")),
        body: SingleChildScrollView(controller: ScrollController(),child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                 label: const Text("Name"),
                hintText: "Enter the name",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100)),
                constraints: const BoxConstraints(maxHeight: 80, maxWidth: 400),
               
                
              ),
              controller: _controller,
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  _instance.textinput(givenuserinput: _controller.text);
                },
                child: const Text("Add name")),
            const SizedBox(
              height: 40,
            ),
            Text("Added names"),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 30),
              child: Observer(
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),

                        itemCount: _instance.value.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_instance.value[index]),
                              const SizedBox(
                                width: 50,
                              ),
                              ElevatedButton(
                                  onPressed: () {
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
        )),);
  }
}
