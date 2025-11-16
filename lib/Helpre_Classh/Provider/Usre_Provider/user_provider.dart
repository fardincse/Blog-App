import 'package:blog_app/Helpre_Classh/api/Profile/edit_profile_api.dart';
import 'package:blog_app/Helpre_Classh/api/Profile/get_user_profile_api.dart';
import 'package:blog_app/Model/Login_Model/get_from_login.dart';
import 'package:blog_app/Model/Profile/get_user_profile_model.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier{
  String userProfile = 'assets/images/profile.jpg';
  GetUserProfileModel? _userProfile;
  GetUserProfileModel? get userProfileData => _userProfile;
  GetFromLogin? _user;
  GetFromLogin? get user => _user;

  void addUserData(GetFromLogin? data){
    _user = data;
    notifyListeners();
  }

  Future getUserProfileData() async{
    final data = await getUserProfile();
    _userProfile = data;
    notifyListeners();
    return _userProfile;
  }

  Future editUserProfile(String name, String phone) async{
    final res = await editUser(name, phone);
    if(res == true){
      getUserProfileData();
      return true;
    }
    notifyListeners();
  }
}