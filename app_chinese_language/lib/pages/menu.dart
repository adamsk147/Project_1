import 'package:app_chinese_language/pages/my_stye.dart';
import 'package:app_chinese_language/pages/vowels_in_chinese.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chinese_show.dart';

class MyMenu extends StatefulWidget {
  @override
  _MyMeunState createState() => _MyMeunState();
}

class _MyMeunState extends State<MyMenu> {
  String name, email;
  Widget currentWidgt = ChineseShow();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findNameAnEmail();
  }

  Future<Null> findNameAnEmail() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      setState(() {
        name = event.displayName;
        email = event.email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
      ),
      drawer: buildDrawer(),
      body: currentWidgt,
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      child: Stack(
        children: [
          Column(
            children: [
              buildUserAccountsDrawerHeader(),
              buildListTileChineseShow(),
              buildListTileVowelsChinese(),
            ],
          ),
          buildSignOut(),
        ],
      ),
    );
  }

  ListTile buildListTileChineseShow() {
    return ListTile(
      leading: Icon(
        Icons.face,
        size: 36,
      ),
      title: Text('ภาษาจีนประจำวัน'),
      subtitle: Text('ภาษาจีนที่ใช้ในชีวิตประจำวัน'),
      onTap: () {
        setState(() {
          currentWidgt = ChineseShow();
        });
        Navigator.pop(context);
      },
    );
  }

  ListTile buildListTileVowelsChinese() {
    return ListTile(
      leading: Icon(
        Icons.face,
        size: 36,
      ),
      title: Text('สระและพยัญชนะภาษาจีน'),
      subtitle: Text('สระและพยํญชนะจีน'),
      onTap: () {
        setState(() {
          currentWidgt = VowelsChinese();
        });
        Navigator.pop(context);
      },
    );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/image/book_1.jpg'), fit: BoxFit.cover),
      ),
      accountName: Text(name == null ? 'Name' : name),
      accountEmail: Text(email == null ? 'email' : email),
      currentAccountPicture: Image.asset('assets/image/menu_3.png'),
    );
  }

  Column buildSignOut() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            await FirebaseAuth.instance.signOut().then((value) =>
                Navigator.pushNamedAndRemoveUntil(
                    context, '/authen', (route) => false));
          },
          tileColor: MyStyle().dakColor,
          leading: Icon(
            Icons.exit_to_app,
            color: Colors.white,
            size: 36,
          ),
          title: Text('Sign Out'),
          subtitle: Text('Sign Out & Go to Authnen'),
        ),
      ],
    );
  }
}
