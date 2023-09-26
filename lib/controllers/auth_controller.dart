import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_location_app/ui/screens/map/map_screen.dart';

class AuthController extends GetxController {
  late Rx<User?> firebaseUser;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(
      firebaseUser,
      _setInitialScreen,
    );
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      debugPrint("failed");
    } else {
      debugPrint("success");
      Get.offAll(() => MapScreen());
    }
  }

  void login(String email, password) async {
    try {
      var aa = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(aa);
    } catch (error) {
      FirebaseAuthException ee = error as FirebaseAuthException;
      Get.snackbar("Error", ee.message ?? "",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  void signOut() async {
    await auth.signOut();
  }
}
