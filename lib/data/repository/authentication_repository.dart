import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_app/data/models/user_model.dart';
import 'package:health_app/view/on_boarding/on_boarding_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AuthenticationRepository {
  static AuthenticationRepository  get instance => Get.find();

  final _db=FirebaseFirestore.instance;
  createUser(UserModel user) async {
    await _db.collection("user").add(user.toJson()).whenComplete(
        ()=> Get.snackbar("Success","you acccount has been created",
        snackPosition:SnackPosition.BOTTOM,
        backgroundColor:Colors.green,
        colorText:Colors.green),
    );
  }
  final deviceStorage = GetStorage();
  @override
  void onReady() {
    screenRedirect();
  }

  screenRedirect() async {
    //   local storage
    deviceStorage.writeIfNull('isfirsttime', true);
    deviceStorage.read('isfirsttime') != true
        ? Get.offAll(() => const OnBoardingView())
        : Get.offAll(const OnBoardingView());
  }
}
