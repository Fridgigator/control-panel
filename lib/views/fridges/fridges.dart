import 'package:control_panel/data_structures/main_widget.dart';
import 'package:control_panel/view_model/main_view/fridges/overview.dart';
import 'package:control_panel/views/fridges/add_fridge/add_fridge_dialog.dart';
import 'package:control_panel/views/fridges/fridge_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Fridges extends MainWidget {
  final bool darkTheme;
  final bool smallDevice;
  final String accessToken;
  const Fridges(
      {super.key,
      required this.darkTheme,
      required this.smallDevice,
      required this.accessToken});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => FridgeViewModel())],
        builder: (context, child) {
          return Provider.of<FridgeViewModel>(context).finishedLoading
              ? SingleChildScrollView(
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: Provider.of<FridgeViewModel>(context)
                        .fridges
                        .map(
                          (fridge) => FridgeCard(
                            darkTheme: darkTheme,
                            fridge: fridge,
                            accessToken: accessToken,
                          ),
                        )
                        .toList(),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  @override
  Widget getSideBar(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Hub 1'),
          onTap: () {},
        ),
        ListTile(
          title: const Text('Hub 2'),
          onTap: () {},
        ),
        ListTile(
          title: const Text('Hub 3'),
          onTap: () {},
        ),
        ListTile(
          title: const Text('Hub 4'),
          onTap: () {},
        ),
        ListTile(
          title: const Text('Hub 5'),
          onTap: () {},
        ),
      ],
    );
  }

  @override
  FloatingActionButton? getFAB(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          if (!smallDevice) {
            AddDialog.startDialog(context, accessToken);
          } else {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddDialog.replaceMain(accessToken),
            ));
          }
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add));
  }

  @override
  bool hasSideBar() {
    return true;
  }
}
