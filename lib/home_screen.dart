
import 'package:bugtracker_client/Providers/data_provider.dart';
import 'package:bugtracker_client/bug_form_screen.dart';
import 'package:bugtracker_client/bug_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

   

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bug Tracker',style: TextStyle(fontWeight: FontWeight.bold),),
        
      ),
      floatingActionButton: MaterialButton(onPressed:((){
        Navigator.push(context, MaterialPageRoute(builder: ((context) =>   const BugForm(addBug: true,))));
      }), 
      child: const CircleAvatar(radius: 35,child: Text('+',style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold
      ),
      ),
      ),
    ),
    body: Consumer<DataProvider>(
      builder: (context, value, _) =>  FutureBuilder(
        future: Provider.of<DataProvider>(context).getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: value.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      tileColor: Theme.of(context).primaryColorLight,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: ((context) => BugScreen(
                       bugInformation : value.data[index]
                       ))));
                      },
                      isThreeLine: true,
                      leading: Text(value.data[index]['title'],style:const TextStyle(fontWeight:FontWeight.bold,fontSize:16),),
                      title: Text(value.data[index]['description'],softWrap: true,),
                      subtitle: Text(value.data[index]["due_date"]??""),

                      trailing:  IconButton(onPressed: (){
                        try{
                        value.deleteData(value.data[index]['_id']);
                        }catch(error){
                         throw Exception(error.toString());

                        }
                        },
                       icon: const Icon(Icons.delete_outline_rounded,color: Colors.red,))
                    ),
                  );
                  
                },
              );
            
          } else if (snapshot.hasError) {
            throw Exception(snapshot.error.toString());

          }
        
          // By default, show a loading spinner
          return const Center(child:CircularProgressIndicator());
        },
        ),
    ),
    );
    
    
  }
}