import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_screen_2/shared/components/margin/margin.dart';

class SmallClickableCard extends StatelessWidget {
  final String title;
  final String svgPath;
  final Function onTap;
  const SmallClickableCard({
    super.key,
    required this.title,
    required this.svgPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        // color: const Color.fromRGBO(252, 252, 253, 1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromRGBO(252, 252, 253, 1),
        ),
        child: Column(
          children: [
            const Margin(height: 30),
            SvgPicture.asset(
              svgPath,
              semanticsLabel: "back icon",
            ),
            const Margin(height: 20),
            Text(
              title,
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
