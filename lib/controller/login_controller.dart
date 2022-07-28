import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weight_tracker/core/routes/app_pages.dart';

class LoginController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  RxBool isLoading = false.obs;

  void signInAnonymous() async {
    isLoading.value = true;
    User? user = (await auth.signInAnonymously()).user;

    if (user != null && user.isAnonymous == true) {
      isLoading.value = false;
      Get.offAllNamed(AppRoutes.goToHomeRoute(), arguments: auth.currentUser);
      Get.snackbar(
        'Auth',
        'Authed is Success.',
        colorText: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 40) +
            const EdgeInsets.symmetric(horizontal: 16),
      );
    } else {
      isLoading.value = false;
      Get.snackbar(
        'Auth',
        'Auth is faild.',
        colorText: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 40) +
            const EdgeInsets.symmetric(horizontal: 16),
      );
    }
  }

  void signOut() async {
    await auth.signOut();
    Get.offAllNamed(AppRoutes.goToLoginRoute());
  }
}
