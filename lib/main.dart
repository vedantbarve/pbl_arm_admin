import 'package:beamer/beamer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pbl_arm_admin/models/record_model.dart';
import 'package:pbl_arm_admin/screens/authentication/authentication.dart';
import 'package:pbl_arm_admin/screens/landing.dart';
import 'package:pbl_arm_admin/screens/records/record_details.dart';
import 'package:pbl_arm_admin/screens/records/records.dart';
import 'screens/home/home.dart';
import 'screens/room/room.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(RootWidget());
}

class RootWidget extends StatelessWidget {
  RootWidget({Key? key}) : super(key: key);

  final routeDelegate = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/': (context, state, data) {
          return const BeamPage(
            title: 'Landing',
            child: LandingWidget(),
          );
        },
        '/home': (context, state, data) {
          return const BeamPage(
            title: 'Home',
            child: HomeView(),
          );
        },
        '/auth': (context, state, data) {
          return const BeamPage(
            title: 'Authentication',
            child: AuthView(),
          );
        },
        '/records': (context, state, data) {
          return const BeamPage(
            title: 'Records',
            child: RecordsView(),
          );
        },
        '/record_details': (context, state, data) {
          return BeamPage(
            title: 'Record Details',
            child: RecordDetailsView(
              recordModel: data as RecordModel,
            ),
          );
        },
        '/room/:roomId': (context, state, data) {
          final roomId = state.pathParameters["roomId"];
          return BeamPage(
            title: 'room',
            popToNamed: '/',
            child: RoomView(roomId: roomId!),
          );
        },
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scrollBehavior: const ScrollBehavior().copyWith(
        physics: const BouncingScrollPhysics(),
      ),
      debugShowCheckedModeBanner: false,
      routeInformationParser: BeamerParser(),
      routerDelegate: routeDelegate,
    );
  }
}
