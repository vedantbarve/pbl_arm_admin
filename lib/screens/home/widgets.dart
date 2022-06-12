import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            onTap: () {
              context.beamToNamed('/records');
            },
            title: const Text('Records'),
            trailing: const Icon(Icons.list),
          ),
          ListTile(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
            },
            title: const Text('Signout'),
            trailing: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
