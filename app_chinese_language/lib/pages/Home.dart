import 'package:app_chinese_language/pages/chinese_show.dart';
import 'package:app_chinese_language/pages/dictionary.dart';
import 'package:app_chinese_language/pages/games.dart';
import 'package:app_chinese_language/pages/my_stye.dart';
import 'package:app_chinese_language/pages/quiz.dart';
import 'package:app_chinese_language/pages/vowels_in_chinese.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name, email;
  Widget currentWidgt = ChineseShow();
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
      body: ChineseShow(),
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
              buildListTileQuizChinese(),
              buildListTileDictionaryChinese(),
              buildListTileGamesChinese(),
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
        Icons.ac_unit_sharp,
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

  ListTile buildListTileDictionaryChinese() {
    return ListTile(
      leading: Icon(
        Icons.book,
        size: 36,
      ),
      title: Text('พจนานุกรม'),
      subtitle: Text('พจนานุกรมและคำศัพท์ภาษาจีน'),
      onTap: () {
        setState(() {
          currentWidgt = DictionaryChinese();
        });
        Navigator.pop(context);
      },
    );
  }

  ListTile buildListTileQuizChinese() {
    return ListTile(
      leading: Icon(
        Icons.book_online_outlined,
        size: 36,
      ),
      title: Text('แบบฝึกหัด'),
      subtitle: Text('แบบฝึกหัดภาษาจีน'),
      onTap: () {
        setState(() {
          currentWidgt = QuizChinese();
        });
        Navigator.pop(context);
      },
    );
  }

  ListTile buildListTileGamesChinese() {
    return ListTile(
      leading: Icon(
        Icons.gamepad_outlined,
        size: 36,
      ),
      title: Text('เกมส์'),
      subtitle: Text('มินิเกมส์'),
      onTap: () {
        setState(() {
          currentWidgt = GamesChimese();
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
          tileColor: Colors.blue,
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
