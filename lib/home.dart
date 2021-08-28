import 'package:flutter/material.dart';

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

  bool isCompleted = false;

  double movedWith = 0;

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
                SizedBox(
                  height: height * 0.4 + _curvedAnimation.value * height * 0.3,
                  child: Opacity(
                    opacity: (_curvedAnimation.value < 0)
                        ? 0
                        : _curvedAnimation.value,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: height * .2,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: AnimatedOpacity(
                            opacity: (_animationController.isCompleted) ? 1 : 0,
                            duration: Duration(seconds: 1),
                            child: Icon(
                              Icons.check_rounded,
                              color: Colors.white,
                              size: height * .15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onHorizontalDragUpdate: (updateDetails) {
                    if (updateDetails.localPosition.dx > 0) {
                      setState(() {
                        movedWith = updateDetails.localPosition.dx;
                      });
                    }
                    if (updateDetails.localPosition.dx >= width * .6) {
                      print("complete ${updateDetails.localPosition.dx}");
                      setState(() {
                        isCompleted = true;
                      });

                      _animationController.forward();
                    }
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: height * .1,
                        width: width * .6,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: height * .1,
                            width: movedWith,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: height * .025,
                        left: width * .15,
                        child: SizedBox(
                          width: width * .3,
                          height: height * .05,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Slide to Continue!",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
