import 'package:bugtracker_client/home_screen.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

 @override
  void initState() {
     super.initState();
    Future.delayed(const Duration(seconds: 3),(() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
    }));
   
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
            Icon(Icons.bug_report_rounded,size: 36,),
            Text('Bug Tracker',style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),)
          ],),
        ),
    );
  }
}