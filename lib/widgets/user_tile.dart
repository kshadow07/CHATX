import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserTile extends StatelessWidget {
  final String text;

  final void Function()? ontap;
  UserTile({super.key, required this.text, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: ontap,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
            padding:
                const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 45,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      text,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Divider(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
