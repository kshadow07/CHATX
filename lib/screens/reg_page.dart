import 'package:chtx/screens/contactpage.dart';
import 'package:chtx/screens/login_page.dart';
import 'package:chtx/services/auth/authservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/BOTTON.dart';
import '../widgets/text_FILED.dart';

class Reg_Page extends StatefulWidget {
  static String id = 'regpage';

  const Reg_Page({super.key});
  @override
  State<Reg_Page> createState() => _Reg_PageState();
}

class _Reg_PageState extends State<Reg_Page> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController confirmpasscontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();

  void reg(context) async {
    // authservice
    final authservice = Authservice();
    try {
      if (passcontroller.text != confirmpasscontroller.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            elevation: 15,
            backgroundColor: Theme.of(context).colorScheme.error,
            content: Text(
              'Password Do Not Match',
            ),
          ),
        );
      } else {
        await authservice.signinwithemailandpass(
            emailcontroller.text.toString().trim(),
            passcontroller.text.toString().trim(),
            namecontroller.text.toString());
        Navigator.pushNamed(context, ContactPage.id);
      }
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

  void Function(bool)? color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Flexible(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Sign up',
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
            InputBox(
              suffixicon: null,
              icon: const Icon(Icons.person),
              ontap: () {},
              focusNode: null,
              obsuretext: false,
              controller: namecontroller,
              hintstring: "Unique Name",
              keybordtype: TextInputType.name,
            ),
            InputBox(
              suffixicon: null,
              icon: Icon(Icons.email),
              ontap: () {},
              focusNode: null,
              obsuretext: false,
              controller: emailcontroller,
              hintstring: "Email",
              keybordtype: TextInputType.emailAddress,
            ),
            InputBox(
              suffixicon: null,
              icon: Icon(Icons.key),
              ontap: () {},
              focusNode: null,
              obsuretext: true,
              controller: passcontroller,
              hintstring: "Password",
              keybordtype: TextInputType.visiblePassword,
            ),
            InputBox(
              suffixicon: null,
              icon: Icon(Icons.key),
              ontap: () {},
              focusNode: null,
              obsuretext: true,
              controller: confirmpasscontroller,
              hintstring: "Confirm Password",
              keybordtype: TextInputType.visiblePassword,
            ),
            Flexible(
              child: Image.asset(
                scale: 2,
                'assets/ui1.png',
              ),
            ),
            REGBOX(
              onTap: () => reg(context),
              pagename: 'Register?',
              width: 400,
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, Login_Page.id),
              child: const Center(
                  child: Text(
                'Already a user??',
                style: TextStyle(
                  fontSize: 16,
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
