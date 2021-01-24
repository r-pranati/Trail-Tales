import 'package:flutter/material.dart';
import './user_auth.dart';
import 'package:Trailtales/userauth_provider.dart';
import './sgscape.dart';
import './working.dart';

class CustomDrawer extends StatelessWidget {
  final Function closeDrawer;

  const CustomDrawer({Key key, this.closeDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      color: Colors.pink[100],
      width: mediaQuery.size.width * 0.60,
      height: mediaQuery.size.height,
      child: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 200,
              color: Colors.pink[500],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Applogo(100, 100),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Trail tales")
                ],
              )),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => WorkingIt(),
                ),
              );
            },
            leading: Icon(Icons.person),
            title: Text(
              "Your Profile",
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => WorkingIt(),
                ),
              );
            },
            leading: Icon(Icons.settings),
            title: Text("Settings"),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => WorkingIt(),
                ),
              );
            },
            leading: Icon(Icons.map),
            title: Text("Previous Trails"),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              debugPrint("About Us");
              showAboutDialog(
                  applicationIcon: Applogo(70, 70),
                  context: context,
                  applicationName: 'Trail Tales',
                  applicationVersion: '0.1.1',
                  applicationLegalese:
                      'Developed By Arindam Shiva Tripathi & Pranati Rajagopal.');
            },
            leading: Icon(Icons.info_outline),
            title: Text("About Us"),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () async {
              try {
                Auth auth = Provider.of(context).auth;
                await auth.signOut();
                print('Signing out user');
                Navigator.popUntil(
                  context,
                  ModalRoute.withName("/"),
                );
              } catch (e) {
                print(e);
              }
              // print('Signing out user');
            },
            leading: Icon(Icons.exit_to_app),
            title: Text("Log Out"),
          ),
        ],
      ),
    );
  }
}
