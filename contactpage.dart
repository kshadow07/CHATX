import 'dart:async';

import 'package:chtx/screens/Setting.dart';
import 'package:chtx/screens/chat.dart';
import 'package:chtx/screens/login_page.dart';
import 'package:chtx/services/auth/authservice.dart';
import 'package:chtx/services/chat/chatservice.dart';
import 'package:chtx/widgets/user_tile.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ContactPage extends StatefulWidget {
  ContactPage({super.key});
  static String id = 'contactpage';

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final Authservice _authservice = Authservice();
  final ChatService _chatService = ChatService();

  Future<void> logout() async {
    final auth = Authservice();
    await auth.logout();
    Navigator.pushNamed(context, Login_Page.id);
  }

  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlert = false;
  void getConnectivity() {
    subscription = Connectivity().onConnectivityChanged.listen(
      (result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlert == false) {
          showDialogBox();
          setState(() {
            isAlert = true;
          });
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getConnectivity();
    Future.delayed(Duration(milliseconds: 0), () => intro());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription.cancel();
  }

  void intro() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 800),
        elevation: 15,
        backgroundColor: Colors.green.shade600,
        content: Text(
          'Logged in',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onSurface),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        elevation: 0,
        title: Text(
          'C H A T X',
          style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      drawer: buildDrawer(context),
      body: buildUserList(),
    );
  }

  Widget buildUserList() {
    String? senderId = _authservice.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getUserStream(),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return const Text('error');
          }
          //loading..
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading..');
          } else {
            return ListView(
              children: snapshot.data!
                  .map<Widget>(
                      (userData) => _buildUserListItem(userData, context))
                  .toList(),
            );
          }
        });
  }

  // building indiviual list data
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // display all user except current user
    if (userData['uid'] != _authservice.getCurrentUser()!.uid) {
      return UserTile(
          text: userData['username'],
          ontap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    receviersemail: userData['email'],
                    receviersid: userData['uid'],
                    username: userData['username'],
                  ),
                ));
          });
    } else {
      return Container();
    }
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: Image.asset(
                    'assets/applogo1.png',
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                },
                contentPadding: EdgeInsets.only(left: 20),
                leading: Icon(
                  Icons.home_filled,
                ),
                title: Text(
                  'H O M E',
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingPage()));
                },
                contentPadding: EdgeInsets.only(left: 20),
                leading: Icon(
                  Icons.settings,
                ),
                title: Text(
                  'S E T T I N G',
                ),
              ),
            ],
          ),
          ListTile(
            onTap: logout,
            contentPadding: EdgeInsets.only(left: 20),
            leading: Icon(
              Icons.logout,
            ),
            title: Text(
              'L O G O U T',
            ),
          ),
        ],
      ),
    );
  }

  showDialogBox() => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: Colors.grey,
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          contentPadding: EdgeInsets.all(10),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context, "Cancel");
                setState(() => isAlert = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected) {
                  showDialogBox();
                  setState(() => isAlert = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
