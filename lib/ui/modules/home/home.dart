import 'package:echat/app/constants/constants.dart';
import 'package:echat/controllers/home_controller.dart';
import 'package:echat/models/user_model.dart';
import 'package:echat/ui/widgets/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    // print(currentUser.email);
    return Scaffold(
        drawer: SidePanel(),
        appBar: AppBar(),
        body: SafeArea(
            child: Obx((){
              return homeController.isLoading.isTrue ?
               const Center(child: CircularProgressIndicator(),)
               : ListView.separated(
              separatorBuilder: (context, index){return Divider(color: Colors.grey.shade300, height: 2.0,);},
              itemBuilder: (context, index){
                return ListTile(
                  leading: CircleAvatar(child: Text(homeController.users![index].name[0]),),
                  title: Text(homeController.users![index].name.toString()),
                  trailing: IconButton(icon: const Icon(Icons.arrow_back_ios_new_outlined), onPressed: (){
                    Get.toNamed('/chat', arguments: homeController.users![index]);
                  },),
                  onTap: (){
                    Get.toNamed('/chat', arguments: homeController.users![index]);
                  },
                );
              },
              itemCount: homeController.users!.length
              );

            })
            
            ));
  }
}
