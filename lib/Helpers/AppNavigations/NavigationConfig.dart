// ignore_for_file: constant_identifier_names, file_names, non_constant_identifier_names
import '../../HomePage/HomePage.dart';
import 'NavigationHelpers.dart';

// Declare the Routes as Enum
enum Routes {
  HomePage,
}

// Create class named Pages which holds the pages in the application 
class Pages{ 
   
  // Specify the page configuration of the home screen and specify the route as tue Homescreen's route
  static final PageConfig homeScreenConfig = PageConfig(route: Routes.HomePage , build: (_) => const MyHomePage());
}