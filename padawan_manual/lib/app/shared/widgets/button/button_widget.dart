import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

/// Classe responsável por construir um botão personalizado.
class ButtonWidget extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final double width;
  final double height;
  const ButtonWidget({
    Key key,
    @required this.text,
    this.onPressed,
    this.width = 120,
    this.height = 40,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => Container(
        width: width ?? constraints.maxWidth,
        height: height ?? constraints.maxHeight,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: FlatButton(
          color: Theme.of(context).primaryColor,
          onPressed: onPressed,
          child: Text(
            text,
            style: Theme.of(context).textTheme.button,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
