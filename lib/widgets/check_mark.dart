import 'package:flutter/material.dart';

class CheckMark extends StatelessWidget {
  const CheckMark({
    Key? key,
    required this.height,
    required Animation<double> curvedAnimation,
    required AnimationController animationController,
  })  : _curvedAnimation = curvedAnimation,
        _animationController = animationController,
        super(key: key);

  final double height;
  final Animation<double> _curvedAnimation;
  final AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.4 + _curvedAnimation.value * height * 0.3,
      child: Opacity(
        opacity: (_curvedAnimation.value < 0) ? 0 : _curvedAnimation.value,
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
    );
  }
}
