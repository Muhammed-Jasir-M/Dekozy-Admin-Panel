import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Firebase Auth Instance
  final _auth = FirebaseAuth.instance;

  // Get Authenticated User Data
  User? get authUser => _auth.currentUser;

  // Get IsAuthenticated User
  bool get isAuthenticated => _auth.currentUser != null;

  @override
  void onReady() {
    // // Redirect to the appropriate screen
    // screenRedirect();

    _auth.setPersistence(Persistence.LOCAL);
  }

  // Function to describe the relevant screen and redirect accordingly
   void screenRedirect() async {
    final user = _auth.currentUser;

    //  If the user is logged in
     if (user != null) {
       // Navigate to the Home
       Get.offAllNamed(ARoutes.dashboard);
     } else {
       Get.offAllNamed(ARoutes.login);
     }
   }

  // Login

  // Register

  // Register User By Admin

  // Email Verification

  // Forget Password

  // Re Authenticate User

  // Logout User

  // Delete User
}
