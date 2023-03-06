import 'package:bugtracker_client/bug_form_screen.dart';
import 'package:flutter/material.dart';


class BugScreen extends StatelessWidget {
  final Map<String,dynamic>? bugInformation;
  
  const BugScreen({ this.bugInformation,super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).primaryColor,
      title: const Text('Bug Details',style: TextStyle(fontWeight: FontWeight.bold),),
    leading: InkWell(onTap: () {
      Navigator.pop(context);
    }, child: const Icon(Icons.arrow_back)),
    actions: [
      IconButton(onPressed: (() {
        Navigator.push(context, MaterialPageRoute(builder: ((context) => BugForm(addBug: false,bugData: bugInformation,))));
      }), icon: const Icon(Icons.edit_outlined))
    ],
    ),
      
    body: SingleChildScrollView(
      child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                
               
                MyTextField(bugInformation: bugInformation,textContent: "Title : ${bugInformation?['title']}",),
                
                MyTextField(bugInformation: bugInformation, textContent: "Description : ${bugInformation?['description']}"),
                
                MyTextField(bugInformation: bugInformation, textContent: "Reporter : ${bugInformation?['reporter']??""}"),
                
                MyTextField(bugInformation: bugInformation, textContent: "Due Date : ${bugInformation?['due_date']??""}"),
               
                MyTextField(bugInformation: bugInformation, textContent: "Project : ${bugInformation?['project']??""}"),
               
                MyTextField(bugInformation: bugInformation,textContent:"File URL : ${bugInformation?['fileUrl']??""}"),
                
                
              ],
            ),
    ),
      );
    
  }
}

class MyTextField extends StatelessWidget {
  final String textContent;
  const MyTextField({
    Key? key,
    required this.bugInformation,
    required this.textContent
  }) : super(key: key);

  final Map<String, dynamic>? bugInformation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
      child: Text(textContent,style: const TextStyle(fontSize: 20,
      fontWeight: FontWeight.bold),),
    );
  }
}