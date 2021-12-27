import 'package:doge_tinder_app/park/bloc/park_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParkFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParkBloc, ParkState>(
      builder: (context, state) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildFilterChipChoices(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChipChoices(BuildContext context) {
    int _choiceIndex = 0;
    List<String> _choices = [
      "Hound",
      "Poodle",
      "Terrier",
      "Hound",
      "Poodle",
      "Terrier",
      "Hound",
      "Poodle",
      "Terrier",
    ];
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _choices.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChoiceChip(
              label: Text(_choices[index]),
              selected: _choiceIndex == index,
              selectedColor: Colors.red,
              onSelected: (bool selected) {
                _choiceIndex = selected ? index : 0;
                print('selected a chip');
              },
              backgroundColor: Colors.green,
              labelStyle: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
