import 'package:echat/controllers/home_controller.dart';
import 'package:echat/ui/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SidePanel(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black87),
          elevation: 0, 
          title: Text('eChats App', style: Theme.of(context).textTheme.headline5,), 
          backgroundColor: Colors.deepPurple[100],
        ),
        body: SafeArea(
            child: Obx((){
              return homeController.isLoading.isTrue ?
               const Center(child: CircularProgressIndicator(),)
               : ListView.separated(
              
              itemBuilder: (context, index){
                return ListTile(
                  leading: CircleAvatar(child: Text(homeController.users![index].name[0]),),
                  title: Text(homeController.users![index].name.toString()),
                  trailing: IconButton(icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 17,), onPressed: (){
                    Get.toNamed('/chat', arguments: homeController.users![index]);
                  },),
                  onTap: (){
                    Get.toNamed('/chat', arguments: homeController.users![index]);
                  },
                );
              },
              separatorBuilder: (context, index){
                return Divider(color: Colors.grey.shade300, height: 2.0,);
                },
              itemCount: homeController.users!.length
              );

            })
            
            ));
  }
}
