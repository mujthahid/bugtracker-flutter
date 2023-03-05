
import 'package:bugtracker_client/Providers/data_provider.dart';
import 'package:bugtracker_client/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BugForm extends StatelessWidget {

final bool addBug;
final Map<String,dynamic>? bugData;
   const BugForm({this.bugData,required this.addBug, super.key});


  @override
  Widget build(BuildContext context) {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController projectController = TextEditingController();
  final TextEditingController reporterController = TextEditingController();
  final TextEditingController fileUrlController = TextEditingController();

  titleController.text = addBug? "" : bugData?["title"]; 
  descriptionController.text = addBug? "" : bugData?["description"]??"";
  dateController.text = addBug? "" : bugData?["due_date"]??"";
  projectController.text = addBug? "" : bugData?["project"]??"";
  reporterController.text = addBug? "" : bugData?["reporter"]??"";
  fileUrlController.text = addBug? "" : bugData?["fileUrl"]??"";
  
  return Scaffold(
      
      appBar: AppBar(backgroundColor: Theme.of(context).primaryColor, title: Text(addBug ? "Add Bug" : "Edit Bug"),
      leading: InkWell(onTap: () {
        Navigator.pop(context);
      }, child: const Icon(Icons.arrow_back)),
      ),
      body: ListView(
        children:  [
           MyTextFormField(labelText: "title",textController: titleController),
           MyTextFormField(labelText: "description",minLines: 3,maxLines: 6,textController: descriptionController),
           MyTextFormField(labelText: "project",textController: projectController),
           MyTextFormField(labelText: "due date",textController: dateController,hintText:"YYYY-MM-DD",),
           MyTextFormField(labelText: "reporter",textController: reporterController),
           MyTextFormField(labelText: "file Url",textController: fileUrlController,),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: MaterialButton(color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
             onPressed: (() async{

  final Map<String,dynamic> postingData = {
  "title": titleController.text,
  "description" : descriptionController.text,
  "due_date" : dateController.text,
  "project" : projectController.text,
  "reporter" : reporterController.text,
  "fileUrl":fileUrlController.text
  }; 

    if(addBug){ 
      Provider.of<DataProvider>(context,listen:false).postData(postingData);
      Navigator.pop(context);
      }
    else{
    Provider.of<DataProvider>(context,listen:false).updateData(bugData?["_id"], postingData);
    Navigator.of(context).popUntil((route) => route.isFirst);
    }
    
  }),
             child: const Text('Submit'),),
          )
        ],
      )
    );
  }
}

class MyTextFormField extends StatelessWidget {
  final String? initialValue;
  final String labelText;
  final int? maxLines;
  final int? minLines;
  final String ? hintText;
  final TextEditingController textController;  
   
   
  const MyTextFormField({
     this.initialValue,
     this.hintText,
      required this.labelText,
      required this.textController,
    this.maxLines,
    this.minLines,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: textController,
        maxLines: maxLines,
        minLines: minLines,
        decoration:   InputDecoration(
          label:  Text(labelText),
          hintText: hintText,
          border: const OutlineInputBorder()
        ),
        
      ),
    );
  }
}