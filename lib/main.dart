import 'package:beamer/beamer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/room.dart';

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
            title: 'Home',
            child: HomeView(),
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
