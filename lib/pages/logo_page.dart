import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:select_avatar/entity/my_colors.dart';
import 'package:select_avatar/pages/intro_page.dart';

class LogoScreen extends StatefulWidget {


  @override
  State<LogoScreen> createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> with TickerProviderStateMixin {


  void navigateToNextPage(BuildContext context) {
    Future.delayed(Duration(milliseconds: 3500), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => IntroName()),
      );
    });
  }

  late AnimationController _animationController;
  late AnimationController _animationController2;

  late Animation<double> _alphaAnimationValues;
  late Animation<double> _scaleAnimationValues;



  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(milliseconds: 2000), vsync: this);
    _alphaAnimationValues = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController2 = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
    _scaleAnimationValues = Tween(begin: 10.0, end: 36.0).animate(_animationController2)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
    _animationController2.forward();
    navigateToNextPage(context);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _animationController2.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: MyColors.mc_lightCyan  ,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 100,top: 50),
                child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Opacity(
                        opacity: _alphaAnimationValues.value,
                        child: Image.asset("images/self-improvement.png"))),
              ),
              Text("BetterSelf",style: TextStyle(fontSize: _scaleAnimationValues.value , fontFamily: 'Agbalumo',color: MyColors.mc_rosyBrown,fontWeight: FontWeight.bold), ),
            ],
          ),
        ),
      ),
    );
  }
}
