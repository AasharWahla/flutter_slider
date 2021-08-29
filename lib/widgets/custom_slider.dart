import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final double height, width;
  final Function onCompleted;
  final AnimationController animationController;
  CustomSlider({
    Key? key,
    required this.height,
    required this.width,
    required this.animationController,
    required this.onCompleted,
  }) : super(key: key);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double movedWidth = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (updateDetails) {
        if (updateDetails.localPosition.dx > 0) {
          setState(() {
            movedWidth = updateDetails.localPosition.dx;
          });
        }
        if (updateDetails.localPosition.dx >= widget.width * .6) {
          print("complete ${updateDetails.localPosition.dx}");
          widget.onCompleted();
          widget.animationController.forward();
        }
      },
      child: Stack(
        children: [
          Container(
            height: widget.height * .1,
            width: widget.width * .6,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: widget.height * .1,
                width: movedWidth,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Positioned(
            top: widget.height * .025,
            left: widget.width * .15,
            child: SizedBox(
              width: widget.width * .3,
              height: widget.height * .05,
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
    );
  }
}
