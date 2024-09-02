import 'package:flutter/material.dart';

class REGBOX extends StatelessWidget {
  const REGBOX(
      {super.key,
      required this.onTap,
      required this.pagename,
      required this.width});
  final String pagename;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        borderOnForeground: false,
        type: MaterialType.button,
        shadowColor: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(30),
        elevation: 8,
        color: Theme.of(context).colorScheme.onSurface,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(30)),
            height: 50,
            width: width,
            child: Center(
                child: Text(pagename,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.background,
                    ))),
          ),
        ),
      ),
    );
  }
}
