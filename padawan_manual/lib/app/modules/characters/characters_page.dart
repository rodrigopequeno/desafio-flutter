import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../shared/utils/enums/filter_enum.dart';

import '../../shared/widgets/app_bar/app_bar_widget.dart';
import '../../shared/widgets/background/background_widget.dart';
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
    return BackgroundWidget(
      opacity: 0.8,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBarWidget(),
          body: Column(
            children: [
              _buildTopBar(),
              _buildListBuilder(),
            ],
          )),
    );
  }

  Widget _buildLoading() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              onChanged: controller.setSearch,
              decoration: InputDecoration(
                hintText: " Search by name",
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 2,
            child: Observer(builder: (_) {
              return DropdownButtonFormField<FilterEnum>(
                items: FilterEnum.values
                    .map(
                      (e) => DropdownMenuItem(
                        child: Text(e.description),
                        value: e,
                      ),
                    )
                    .toList(),
                onChanged: controller.setFilter,
                value: controller.filter,
              );
            }),
          )
        ],
      ),
    );
  }

  Widget _buildListBuilder() => Expanded(
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
                        await controller.getCharactersApi(forceNetwork: true);
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
              onRefresh: () => controller.getCharactersApi(forceNetwork: true),
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
      );
}
