import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  final Widget? icon;
  final ButtonStyle? style;
  final bool? disabled;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.icon,
    required this.style,
    this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: disabled == null || disabled! == false ? onPressed : null,
        style: style ??
            ElevatedButton.styleFrom(
              elevation: 7,
              disabledBackgroundColor: const Color.fromRGBO(255, 255, 255, 0.4),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              shadowColor: const Color.fromRGBO(9, 7, 7, 0.1),
              padding: const EdgeInsets.symmetric(
                vertical: 14,
              ),
              backgroundColor: Colors.white,
              textStyle: const TextStyle(
                color: Colors.black,
              ),
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            child,
            icon != null
                ? const SizedBox(
                    width: 20,
                  )
                : const SizedBox(),
            icon ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
