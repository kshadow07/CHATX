import 'dart:async';

import 'package:chtx/screens/contactpage.dart';
import 'package:chtx/screens/reg_page.dart';
import 'package:chtx/services/auth/authservice.dart';
import 'package:chtx/services/chat/chatservice.dart';
import 'package:chtx/widgets/BOTTON.dart';
import 'package:chtx/widgets/text_FILED.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Login_Page extends StatefulWidget {
  static String id = 'loginpage';
  final ChatService _chatService = ChatService();
  final Authservice _authservice = Authservice();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();
  Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
/////

  void login(context) async {
    final authservice = Authservice();
    try {
      await authservice.loginwithemailandpass(
          widget.emailcontroller.text, widget.passcontroller.text);
      Navigator.pushNamed(context, ContactPage.id);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 15,
          backgroundColor: Theme.of(context).colorScheme.error,
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      textAlign: TextAlign.left,
                      'Sign In',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 50,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    'No account?',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Reg_Page.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      'Make account',
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
            InputBox(
              suffixicon: null,
              icon: Icon(Icons.email),
              ontap: () {},
              focusNode: null,
              obsuretext: false,
              controller: widget.emailcontroller,
              hintstring: "Email",
              keybordtype: TextInputType.emailAddress,
            ),
            InputBox(
              suffixicon: null,
              icon: Icon(Icons.key),
              ontap: () {},
              focusNode: null,
              obsuretext: true,
              controller: widget.passcontroller,
              hintstring: "Password",
              keybordtype: TextInputType.visiblePassword,
            ),
            REGBOX(
              onTap: () => login(context),
              pagename: 'Sign In',
              width: 150,
            ),
            Flexible(
              child: Image.asset(
                'assets/ui1.png',
              ),
            ),
          ],
        ),
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
