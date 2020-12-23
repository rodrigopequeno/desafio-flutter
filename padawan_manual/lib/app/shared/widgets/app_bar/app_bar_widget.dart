import 'package:flutter/material.dart';

/// Classe responsável por construir uma appBar personalizada.
class AppBarWidget extends PreferredSize {
  final double height;
  final double elevation;
  final bool back;
  final Widget content;
  final double radius;
  final Color color;
  final List<Widget> actions;

  AppBarWidget({
    this.elevation,
    this.height = kToolbarHeight,
    this.back = true,
    this.content,
    this.radius = 15,
    this.color,
    this.actions,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: back,
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        ),
      ),
      title: Image.asset(
        'assets/images/logo.png',
        height: 40,
      ),
      flexibleSpace: content,
      actions: actions,
      elevation: elevation,
      centerTitle: true,
    );
  }
}
