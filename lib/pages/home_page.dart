import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:select_avatar/entity/my_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {

  String? name;
  String? avatar;
  int? cinsiyet;
  late IconData iconData;

  Future<void> adGoster() async{
    var sp = await SharedPreferences.getInstance();
    setState(() {
      name = sp.getString("isim") ?? "kullanıcı adı yok";
    });
  }

  Future<void> avatarGoster() async{
    var sp = await SharedPreferences.getInstance();
    setState(() {
      avatar = sp.getString("avatar");
    });
  }

  Future<void> cinsiyetGoster() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cinsiyet = prefs.getInt('cinsiyet') ;
      if (cinsiyet == 0) {
        iconData = Icons.female;
      } else {
        iconData = Icons.male;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    adGoster();
    avatarGoster();
    cinsiyetGoster();
  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: MyColors.mc_pureWhite,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.mc_copperRed,
          title: Align(alignment: Alignment.center,child: Text("Profil",style: TextStyle(color: MyColors.mc_cornsilk,fontWeight: FontWeight.bold,),)),

        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30,bottom: 20),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("images/$avatar"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 140,bottom: 100),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15,),
                      child: Icon(iconData),
                    ),
                    Text("$name",style: TextStyle(fontSize: 22,fontFamily: 'NotoSerif'),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
