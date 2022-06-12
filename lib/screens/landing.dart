import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:pbl_arm_admin/screens/authentication/authentication.dart';
import 'package:pbl_arm_admin/screens/home/home.dart';

class LandingWidget extends StatelessWidget {
  const LandingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.data == null) {
          return const AuthView();
        }
        if (snapshot.data != null) {
          return const HomeView();
        }
        return Container();
      },
    );
  }
}
