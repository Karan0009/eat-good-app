import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_screen_2/_mvvm_arch2/shared/components/margin/margin.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final String svgPath;
  const MenuItem({super.key, required this.title, required this.svgPath});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromRGBO(252, 252, 253, 1),
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
        ));
  }
}
