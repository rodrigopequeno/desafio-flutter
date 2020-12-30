import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/utils/extensions/string/string.dart';
import '../../../shared/widgets/app_bar/app_bar_widget.dart';
import '../../../shared/widgets/background/background_widget.dart';
import '../../../shared/widgets/button/button_widget.dart';
import '../models/character/character_model.dart';
import 'characters_details_controller.dart';

class CharactersDetailsPage extends StatefulWidget {
  final String title;
  final CharacterModel character;
  const CharactersDetailsPage(
      {Key key, this.title = "CharactersDetails", @required this.character})
      : super(key: key);

  @override
  _CharactersDetailsPageState createState() => _CharactersDetailsPageState();
}

class _CharactersDetailsPageState
    extends ModularState<CharactersDetailsPage, CharactersDetailsController> {
  @override
  void initState() {
    controller.setDetailsCharacter(widget.character);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      opacity: 0.8,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBarWidget(
          actions: [
            Observer(builder: _buildButtonFavorite),
          ],
        ),
        body: Observer(builder: (_) {
          var character = widget.character;
          if (controller.errorMessage != null) {
            return _buildErrorPage();
          } else if (!controller.loaded) {
            return _buildLoading();
          }
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _header(),
                _details(character),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildLoading() => Center(
        child: CircularProgressIndicator(),
      );

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.character.id != null
                        ? Text(
                            "#${widget.character.id}",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.grey[300]),
                          )
                        : Container(),
                    Flexible(
                      child: Text(
                        """${widget.character.name}""",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.headline5.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _details(CharacterModel character) {
    var _textStyle =
        Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text("Information",
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    """Height: ${character.height}cm""",
                    style: _textStyle,
                  ),
                  Text(
                    """Mass: ${character.mass}kg""",
                    style: _textStyle,
                  ),
                  Text(
                    """Gender: ${character.gender.toFirstLetterUpperCase()}""",
                    style: _textStyle,
                  ),
                  Text(
                    """Birth Year: ${character.birthYear}""",
                    style: _textStyle,
                  ),
                  Text(
                    """Hair Color: ${character.hairColor.toFirstLetterUpperCase()}""",
                    style: _textStyle,
                  ),
                  Text(
                    """Skin Color: ${character.skinColor.toFirstLetterUpperCase()}""",
                    style: _textStyle,
                  ),
                  Text(
                    """Eye Color: ${character.eyeColor.toFirstLetterUpperCase()}""",
                    style: _textStyle,
                  ),
                  Text(
                    """Home World: ${character.homeWorld}""",
                    style: _textStyle,
                  ),
                  Text(
                    """Species: ${character.species.isEmpty ? "Indeterminate" : character.species.toString().replaceAll("[", "").replaceAll("]", "")}""",
                    style: _textStyle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonFavorite(BuildContext context) => IconButton(
        icon: widget.character.isFavorite
            ? Icon(
                Icons.favorite,
                color: Colors.red,
              )
            : Icon(Icons.favorite_border),
        onPressed: () async {
          await controller.setFavorite(widget.character);
        },
      );

  Widget _buildErrorPage() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              controller.errorMessage,
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 20,
            ),
            ButtonWidget(
                text: "Update",
                onPressed: () async {
                  await controller.setDetailsCharacter(widget.character);
                })
          ],
        ),
      );
}
