import 'package:flutter/material.dart';

class InputBox extends StatefulWidget {
  const InputBox({
    super.key,
    required this.suffixicon,
    required this.icon,
    required this.ontap,
    required this.hintstring,
    required this.obsuretext,
    required this.keybordtype,
    required this.controller,
    required this.focusNode,
  });
  final String hintstring;
  final Widget? icon;
  final Widget? suffixicon;
  final bool obsuretext;
  final TextInputType keybordtype;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final void Function()? ontap;

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: TextField(
        onTapAlwaysCalled: true,
        maxLines: 1,
        onTap: widget.ontap,
        controller: widget.controller,
        focusNode: widget.focusNode,
        onChanged: (value) {
          value = widget.controller.text;
        },
        obscureText: widget.obsuretext,
        style: TextStyle(fontWeight: FontWeight.w400),
        keyboardType: widget.keybordtype,
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          suffixIcon: widget.suffixicon,
          prefixIcon: widget.icon,
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          hintText: widget.hintstring,
          hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface, fontSize: 20),
          labelText: widget.hintstring,
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.outline),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
      ),
    );
  }
}
