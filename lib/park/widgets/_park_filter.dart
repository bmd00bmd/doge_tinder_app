import 'package:flutter/material.dart';

class ParkFilter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ParkFilterState();
}

class _ParkFilterState extends State<ParkFilter> {
  late List<String> _choices;
  late int _choiceIndex;

  @override
  void initState() {
    super.initState();
    _choiceIndex = 0;
    _choices = ["Hound", "Poodle", "Terrier"];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildFilterChipChoices(),
        ],
      ),
    );
  }

  Widget _buildFilterChipChoices() {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _choices.length,
        itemBuilder: (BuildContext context, int index) {
          return ChoiceChip(
            label: Text(_choices[index]),
            selected: _choiceIndex == index,
            selectedColor: Colors.red,
            onSelected: (bool selected) {
              setState(() {
                _choiceIndex = selected ? index : 0;
              });
            },
            backgroundColor: Colors.green,
            labelStyle: TextStyle(color: Colors.white),
          );
        },
      ),
    );
  }
}
