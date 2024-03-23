
import 'dart:convert';

import 'package:agrihub/model/Agriculture.dart';
import 'package:get/get.dart';

import '../model/User.dart';
import '../services/AgricultureService.dart';

class AgriInformationController extends GetxController{
  var agriInfo = [].obs;
  var filterInfo = [].obs;
  var searchInput =''.obs;

  @override
  void onInit() async{
    super.onInit();
    fetchAgriInfo();
   }

  Future<bool> addAgriInfo(Agriculture agriculture) async{
    try{
      var resp=  await AgricultureService().createAgriculture(agriculture);

      print(resp);
      return true;

    }catch(e){
      print("Error creating user: $e"); // Log the error
      return false;
    }
    finally{


    }
  }
  void fetchAgriInfo() async{

    var resp = await AgricultureService().getAllAgriInfo();
    var agriList = jsonDecode(resp);
    print(agriList);
    agriInfo.assignAll(agriList.map((e)=>Agriculture.fromJson(e)).toList());
    print("line 71 : get agri list: ${resp}");
  }

}