import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:select_avatar/pages/avatar_select.dart';
import 'package:select_avatar/entity/my_colors.dart';
import 'package:select_avatar/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroName extends StatefulWidget {
  const IntroName({super.key});

  @override
  State<IntroName> createState() => _IntroNameState();
}

class _IntroNameState extends State<IntroName> {

  var tfKullaniciAdi = TextEditingController();
  String? name;
  String avatar = "default.png";
  int? cinsiyet;

  Future<void> adKayit() async{
    var sp = await SharedPreferences.getInstance();
    sp.setString("isim", name!);
  }

  Future<void> avatarGoster() async{
    var sp = await SharedPreferences.getInstance();
    setState(() {
      avatar = sp.getString("avatar")!;
    });
  }

  Future<void> cinsiyetKayit() async{
    var sp = await SharedPreferences.getInstance();
    setState(() {
      sp.setInt("cinsiyet", cinsiyet!) ;
    });
  }


  @override
  void initState() {
    super.initState();
    avatarGoster();
  }

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: MyColors.mc_pureWhite,
        body:SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: SizedBox(width:400, child: Image.asset("images/intro_name.png")),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AvatarSelect()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20,top: 60),
                  child: CircleAvatar(
                    backgroundImage: AssetImage("images/$avatar"),
                    radius: 50.0,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            radius: 15.0,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.add,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 250,
                height: 50,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: "Sana nasıl hitap edelim ?",
                    labelStyle: TextStyle(
                      color: Colors.black26,
                      fontSize: 16,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: MyColors.mc_peru , width: 5)
                    ),
                  ),
                  controller: tfKullaniciAdi,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width/3,
                      child: RadioListTile(
                        title: Icon(Icons.female),
                        value: 0,
                        groupValue: cinsiyet,
                        onChanged: (cinsiyet_value){
                          setState(() {
                            cinsiyet = cinsiyet_value;
                            cinsiyetKayit();
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: width/3,
                      child: RadioListTile(
                        title: Icon(Icons.male),
                        value: 1,
                        groupValue: cinsiyet,
                        onChanged: (cinsiyet_value){
                          setState(() {
                            cinsiyet = cinsiyet_value;
                            cinsiyetKayit();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: ElevatedButton(
                    onPressed: (){
                      setState(() {
                        name = tfKullaniciAdi.text;
                        adKayit();
                        cinsiyetKayit();
                      });
                      if(name!.isNotEmpty){
                        if(avatar!.isNotEmpty){
                          if(cinsiyet != null){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Profil()));
                          }
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.mc_cadetGrey,
                    ),
                    child: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

