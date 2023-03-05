import 'package:bugtracker_client/Providers/data_provider.dart';
import 'package:bugtracker_client/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'Model_Class/response_adaptor.dart';
import 'Model_Class/hive_model.dart';


void main() async{

WidgetsFlutterBinding.ensureInitialized();

final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  // register ResponseData adapter
  Hive.registerAdapter(ResponseDataAdapter());
  // open Hive box
  await Hive.openBox<ResponseData>('response_data');
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MaterialApp(
        title: "Bug Tracker",
        theme: ThemeData(
          primarySwatch: Colors.orange
        ),
         home: const SplashScreen(),
         debugShowCheckedModeBanner: false,
      ),
    );
  }
}