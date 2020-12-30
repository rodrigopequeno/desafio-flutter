import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/utils/extensions/string/string.dart';
import '../../models/character/character_model.dart';

class CharacterWidget extends StatelessWidget {
  final CharacterModel characterModel;
  final void Function() onFavorite;

  const CharacterWidget({Key key, this.characterModel, this.onFavorite})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Modular.to.pushNamed('/character/details', arguments: characterModel);
      },
      title: Text("${characterModel.name}"),
      subtitle: Text(_subtitleFormatted),
      trailing: Observer(builder: (context) => _buildButtonFavorite),
      leading: Container(
          width: 40,
          height: 40,
          child: Image.asset('assets/images/yin-yang.png')),
    );
  }

  String get _subtitleFormatted {
    var gender = characterModel.gender == "n/a"
        ? "N/A"
        : "${characterModel.gender.toFirstLetterUpperCase()}";
    var height = characterModel.height == "unknown"
        ? "Unknown"
        : "${characterModel.height}cm";
    var mass = characterModel.mass == "unknown"
        ? "Unknown"
        : "${characterModel.mass}kg";
    return """Gender: $gender\nHeight: $height - Mass: $mass""";
  }

  Widget get _buildButtonFavorite => IconButton(
        icon: characterModel.isFavorite
            ? Icon(
                Icons.favorite,
                color: Colors.red,
              )
            : Icon(Icons.favorite_border),
        onPressed: onFavorite,
      );
}
