import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/widgets/app_bar/app_bar_widget.dart';
import '../../shared/widgets/button/button_widget.dart';
import 'characters_controller.dart';
import 'widgets/character/character_widget.dart';

class CharactersPage extends StatefulWidget {
  final String title;
  const CharactersPage({Key key, this.title = "Characters"}) : super(key: key);

  @override
  _CharactersPageState createState() => _CharactersPageState();
}

class _CharactersPageState
    extends ModularState<CharactersPage, CharactersController> {
  @override
  void initState() {
    controller.getCharactersApi(forceNetwork: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(),
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        decoration:
                            InputDecoration(hintText: " Search by name"),
                        onChanged: controller.setSearch,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: Observer(builder: (_) {
                        return DropdownButton(
                          items: [
                            DropdownMenuItem(
                              child: Text("All"),
                              value: 0,
                            ),
                            DropdownMenuItem(
                              child: Text("Favorite"),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: Text("No favorite"),
                              value: 2,
                            ),
                          ],
                          onChanged: controller.setFilter,
                          value: controller.filter,
                        );
                      }),
                    )
                  ],
                )),
            Expanded(
              child: Observer(
                builder: (_) {
                  var characters = controller.charactersFiltered;
                  if (characters == null) {
                    return _buildLoading();
                  } else if (controller.errorMessage != null &&
                      controller.characters.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.errorMessage,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ButtonWidget(
                            text: "Update",
                            onPressed: () async {
                              await controller.getCharactersApi(
                                  forceNetwork: true);
                            },
                          ),
                        ],
                      ),
                    );
                  } else if (characters.isEmpty) {
                    if (!controller.isMaximum) {
                      controller.getCharactersApi();
                      return _buildLoading();
                    }
                    return Center(
                        child: Text(
                      "No characters found",
                      style: TextStyle(fontSize: 20),
                    ));
                  }

                  return RefreshIndicator(
                    onRefresh: () =>
                        controller.getCharactersApi(forceNetwork: true),
                    child: ListView.separated(
                      itemCount: characters.length + 1,
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 2.0,
                          indent: 10.0,
                          endIndent: 10.0,
                          color: Colors.white,
                        );
                      },
                      itemBuilder: (_, index) {
                        if (characters.length <= index) {
                          if (controller.errorMessage != null) {
                            return Container(
                              height: 50,
                              child: Center(
                                child: Text(
                                  """Unable to load data.\n${controller.errorMessage}""",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          } else if (controller.isMaximum) {
                            return Container(
                              height: 40,
                            );
                          } else {
                            controller.getCharactersApi();
                            return _buildLoading();
                          }
                        }
                        var character = characters[index];
                        return CharacterWidget(
                          characterModel: character,
                          onFavorite: () async {
                            await controller.setFavorite(character);
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }

  Widget _buildLoading() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
}
