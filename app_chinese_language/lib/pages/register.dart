import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'my_stye.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccount createState() => _CreateAccount();
}

class _CreateAccount extends State<CreateAccount> {
  double height, width;
  bool redEye = true;
  String name, user, password;

  @override
  void initState() {
    super.initState();
    width = 200;
  }

  Container buildDisplayName() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: width * 0.6,
      child: TextField(
        onChanged: (value) => name = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.fingerprint,
            color: MyStyle().dakColor,
          ),
          labelStyle: MyStyle().darStyle(),
          labelText: 'Name:',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: MyStyle().dakColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().lightColor)),
        ),
      ),
    );
  }

  Container buildUser() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: width * 0.6,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.perm_identity,
            color: MyStyle().dakColor,
          ),
          labelStyle: MyStyle().darStyle(),
          labelText: 'User:',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: MyStyle().dakColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().lightColor)),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: width * 0.6,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: redEye,
        decoration: InputDecoration(
          suffixIcon: IconButton(
              icon: Icon(
                redEye
                    ? Icons.remove_red_eye_outlined
                    : Icons.remove_red_eye_sharp,
                color: MyStyle().dakColor,
              ),
              onPressed: () {
                setState(() {
                  redEye = !redEye;
                });
              }),
          prefixIcon: Icon(
            Icons.lock_outlined,
            color: MyStyle().dakColor,
          ),
          labelStyle: MyStyle().darStyle(),
          labelText: 'Password:',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: MyStyle().dakColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().lightColor)),
        ),
      ),
    );
  }

  // Container buildLogin() {
  //   return Container(
  //     margin: EdgeInsets.only(top: 16),
  //     width: width * 0.6,
  //     child: ElevatedButton(
  //       onPressed: () {},
  //       child: Text('Login'),
  //       style: ElevatedButton.styleFrom(
  //           primary: MyStyle().dakColor,
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(20))),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('สมัครสมาชิก'),
        backgroundColor: MyStyle().primaryColor,
      ),
      body: Stack(
        children: [
          MyStyle().buildBackground(width, height),
          buildContent(),
        ],
      ),
    );
  }

  Center buildContent() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildDisplayName(),
            buildUser(),
            buildPassword(),
            // buildLogin(),
            buildCreatAccount(),
          ],
        ),
      ),
    );
  }

  Container buildCreatAccount() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      width: width * 0.6,
      child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: MyStyle().dakColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            print('name = $name, user = $user, password = $password');
            if ((name?.isEmpty ?? true) ||
                (user?.isEmpty ?? true) ||
                (password?.isEmpty ?? true)) {
              print('Have Space');
              normlDialog(context, 'Have Space ?', 'Please Fill Every Blank');
            } else if (user == null) {
              normlDialog(context, 'No TypeUser ? ',
                  'Please Choose Type User by Click User ');
            } else {
              createAccountAndInsertInformation();
            }
          },
          icon: Icon(Icons.cloud_upload),
          label: Text('Create Account')),
    );
  }

  Future<Null> createAccountAndInsertInformation() async {
    await Firebase.initializeApp().then((value) async {
      print('Firebase Ininiaze Success');
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: user, password: password)
          .then((value) => print('Create Account Success'))
          .catchError(
              (onError) => normalDialog(context, onError, onError.message));
    });
  }

  normalDialog(BuildContext context, onError, message) {}

  void normlDialog(BuildContext context, String s, String t) {}
}
