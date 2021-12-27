import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doge_tinder_app/house/bloc/house_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HouseList extends StatefulWidget {
  @override
  _HouseListState createState() => _HouseListState();
}

class _HouseListState extends State<HouseList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HouseBloc, HouseState>(builder: (context, state) {
      final doges = state.doges;
      switch (state.status) {
        case HouseStatus.destroyed:
          return const Center(
            child: Text('the house is destroyed'),
          );
        case HouseStatus.happy:
          return ListView.builder(
            itemCount: doges.length,
            itemBuilder: (context, index) {
              final doge = doges[index];
              return Dismissible(
                key: Key(doge),
                onDismissed: (direction) {
                  setState(() {
                    final removedDoge = doges[index];
                    doges.removeAt(index);
                    context.read<HouseBloc>().add(
                          RemoveDogeFromHouse(removedDoge),
                        );
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$doge removed!'),
                    ),
                  );
                },
                background: Container(
                  color: Colors.red,
                ),
                child: ListTile(
                  title: Text('${_dogeTitle(doge)}'),
                  subtitle: Text('${_dogeId(doge)}'),
                  isThreeLine: true,
                ),
              );
            },
          );
        default:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }

  String _dogeId(String dogeUrl) {
    final bits = dogeUrl.split("/");
    return bits[bits.length - 1];
  }

  String _dogeTitle(String dogeUrl) {
    final bits = dogeUrl.split("/");
    return bits[bits.length - 2].replaceAll("-", " ").toUpperCase();
  }

  String _dogeSubtitle(String dogeUrl) {
    final bits = dogeUrl.split("/");
    return bits.last;
  }
}
