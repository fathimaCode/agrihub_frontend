import 'package:agrihub/Common/NavBar.dart';
import 'package:flutter/material.dart';

import 'package:agrihub/Constant/agri_color.dart';
import 'package:get/get.dart';

import '../../controller/AgriInformationController.dart';
class Admindashboard extends StatelessWidget {
   Admindashboard({super.key});
   final AgriInformationController _agriController =   Get.put(AgriInformationController());
   final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard"),),
      drawer: AdminNavBar(),
      body:  ListView(
        children: [
          Container(


            padding: EdgeInsets.only(right: 15,bottom: 10),
            alignment: Alignment.topRight,
            child: Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: "Search Agriculture",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
              onPressed: (){
                var searchInput = _searchController.text;
                _agriController.filterInfo.value = _agriController.agriInfo
                    .where((agriItem) =>
                agriItem.title.toLowerCase().contains(searchInput.toLowerCase()) ||
                    agriItem.description.toLowerCase().contains(searchInput.toLowerCase()))
                    .toList();
                print("line 50");

              },child: Text("Search",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),)],),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(

                height: AgriColors.screenHeight(context)/1.3,
                width: AgriColors.screenWidth(context),
                child: Obx(
                      () {
                    final agrilist = _agriController.filterInfo.isEmpty? _agriController.agriInfo:_agriController.filterInfo;

                    if (agrilist.isEmpty) {
                      return Center(
                        child: Text("No Agri Information"),
                      );
                    }

                    return ListView.builder(
                      itemCount: agrilist.length,
                      itemBuilder: (context, index) {
                        final agriItem = agrilist[index];
                        return Card(
                          elevation: 5,
                          child: Container(child:
                          Column(children: [
                            Row(children: [
                              Text("Title: ${agriItem.title}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              SizedBox(width: 10,),
                              Container(
                                alignment: Alignment.topRight,
                                child: Text("Created_at: ${agriItem.date}"),
                              ),
                            ],),

                            Text("Description: ${agriItem.description}"),
                            Text("Content: ${agriItem.content}"),

                          ],),),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ));
  }
}
