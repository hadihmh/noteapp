import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_first_co_app/home_screen.dart';

class AuthController extends GetxController {
  late Rx<User?> firebaseUser;

  // late Rx<GoogleSignInAccount?> googleSignInAccount;
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
      // if the user is not found then the user is navigated to the Register Screen
      // Get.offAll(() => const Register());
      print("failed");
    } else {
      print("success");
      // if the user exists and logged in the the user is navigated to the Home Screen
      Get.offAll(() => HomeScreen());
    }
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      FirebaseAuthException ee = error as FirebaseAuthException;
      Get.snackbar("Error", ee.message ?? "",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  void signOut() async {
    await auth.signOut();
  }
}
