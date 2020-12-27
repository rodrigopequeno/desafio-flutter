import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
      subtitle: Text(
          """Height: ${characterModel.height} - Gender: ${characterModel.gender} - Mass: ${characterModel.mass}"""),
      trailing: Observer(
        builder: (context) => IconButton(
          icon: characterModel.isFavorite
              ? Icon(Icons.favorite)
              : Icon(Icons.favorite_border),
          onPressed: onFavorite,
        ),
      ),
    );
  }
}
