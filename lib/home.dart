import 'package:flutter/material.dart';
import 'package:slider/widgets/check_mark.dart';
import 'package:slider/widgets/custom_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _curvedAnimation;
  bool showTick = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _curvedAnimation = _animationController.drive(
      CurveTween(
        curve: Curves.easeInBack,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void appBarColor() {
    setState(() => isCompleted = true);
  }

  bool isCompleted = false;

  double movedWidth = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Slider - by Aashar Wahla"),
        backgroundColor: isCompleted ? Colors.green : Colors.black,
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _curvedAnimation,
          builder: (ctx, child) {
            return Column(
              children: [
                CheckMark(
                  height: height,
                  curvedAnimation: _curvedAnimation,
                  animationController: _animationController,
                ),
                CustomSlider(
                  height: height,
                  width: width,
                  animationController: _animationController,
                  onCompleted: appBarColor,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
