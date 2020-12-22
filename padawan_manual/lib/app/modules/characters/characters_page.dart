import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../shared/widgets/app_bar/app_bar_widget.dart';
import 'characters_controller.dart';

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
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(hintText: " Search by name"),
                onChanged: controller.setSearch,
              ),
            ),
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
                          _buildButtonUpdate(),
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
                        return ListTile(
                          title: Text("${character.name}"),
                          subtitle: Text(
                              """Height: ${character.height} - Gender: ${character.gender} - Mass: ${character.mass}"""),
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

  Widget _buildButtonUpdate() => Container(
        width: 120,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: FlatButton(
          color: Theme.of(context).primaryColor,
          onPressed: () async {
            await controller.getCharactersApi(forceNetwork: true);
          },
          child: Text(
            "Update",
            style: Theme.of(context).textTheme.button,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

  Widget _buildLoading() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
}
