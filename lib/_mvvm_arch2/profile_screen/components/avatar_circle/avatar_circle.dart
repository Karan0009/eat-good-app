import 'package:flutter/material.dart';

class AvatarCircle extends StatelessWidget {
  const AvatarCircle({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.3;
    return Container(
      height: width + 20,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: width,
            height: width,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(214, 248, 184, 1),
              borderRadius: BorderRadius.circular(width),
              border: Border.all(
                color: Colors.white,
                width: 6,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 6,
                ),
              ),
              child: const CircleAvatar(
                backgroundColor: Color.fromRGBO(104, 172, 108, 1),
                child: Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            // Container(
            //   width: 45,
            //   height: 45,
            //   decoration: Circle(
            //     color: const Color.fromRGBO(104, 172, 108, 1),
            //     shape: BoxShape.circle,
            //     // borderRadius: BorderRadius.circular(45),
            //     border: Border.all(
            //       color: Colors.white,
            //       width: 6,
            //     ),
            //   ),
            //   child: const Icon(
            //     Icons.add_rounded,
            //     color: Colors.white,
            //     size: 30,
            //   ),
            // ),
          )
        ],
      ),
    );
  }
}
