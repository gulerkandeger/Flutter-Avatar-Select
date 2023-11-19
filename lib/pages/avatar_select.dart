import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:select_avatar/pages/intro_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvatarSelect extends StatefulWidget {
  const AvatarSelect({super.key});

  @override
  State<AvatarSelect> createState() => _AvatarSelectState();
}

class _AvatarSelectState extends State<AvatarSelect> {

  String selectedAvatar = 'default_avatar.png';
  List<String> avatars = [
    'avatar1.png', 'avatar2.png', 'avatar3.png',
    'avatar4.png', 'avatar5.png', 'avatar6.png',
    'avatar7.png', 'avatar8.png', 'avatar9.png',
    'avatar10.png', 'avatar11.png', 'avatar12.png',
    'avatar13.png', 'avatar14.png', 'avatar15.png',
    'avatar16.png', 'avatar17.png', 'avatar18.png',
    'avatar19.png', 'avatar20.png', 'avatar21.png',
    'avatar22.png', 'avatar23.png', 'avatar24.png'];

  String avatar = 'default_avatar.png';

  Future<void> avatarKayit() async{
    var sp = await SharedPreferences.getInstance();
    sp.setString("avatar", avatar!);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Avatar Seçimi'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                  ),
                  itemCount: avatars.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: CircleAvatar(
                        backgroundImage: AssetImage("images/${avatars[index]}"),
                        radius: 30,
                      ),
                      onTap: (){
                        setState(() {
                          selectedAvatar = avatars[index];
                          avatar=selectedAvatar;
                          avatarKayit();
                        });
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>IntroName()));
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
