
import 'dart:convert';

import 'package:agrihub/model/User.dart';
import 'package:agrihub/services/UserServices.dart';
import 'package:get/get.dart';
class AuthenticationController extends GetxController{
var isLoading = false.obs;
var farmerUsers = [].obs;
@override
void onInit() {
  super.onInit();
  fetchFarmerUsers();

}

Future<bool> createUser(User user) async{
  isLoading.value = true;
  try{
  var resp=  await UserServices().createUser(user);

  print(resp);
  return true;

  }catch(e){
    print("Error creating user: $e"); // Log the error
    return false;
  }
  finally{
    isLoading.value=false;

  }
}
Future<String> AuthorisedUser(String email, String password) async{
  isLoading.value = true;
  try{
    var resp=  await UserServices().isUserExist(email,password);

    return resp;

  }catch(e){
    print("Error creating user: $e"); // Log the error
    return "";
  }
  finally{
    isLoading.value=false;

  }
}


Future<String> approveFarmer(String userid) async{
  isLoading.value = true;
  try{
    var resp=  await UserServices().updateFarmerStatus(userid);
    fetchFarmerUsers();
    return resp;

  }catch(e){
    print("Error creating user: $e"); // Log the error
    return "";
  }
  finally{
    isLoading.value=false;

  }
}



  void fetchFarmerUsers() async{
    var resp=  await UserServices().isFarmer();
    List<dynamic> data = jsonDecode(resp);
    print("line 72:${data}");
    farmerUsers.assignAll(data.map((e) => User.fromJson(e)).toList());
  }
}