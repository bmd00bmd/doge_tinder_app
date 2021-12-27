import 'package:doge_tinder_app/park/bloc/park_bloc.dart';
import 'package:doge_tinder_app/park/widgets/park_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcard/tcard.dart';
import 'package:doge_tinder_app/core/core.dart';
import 'package:doge_tinder_app/core/api/doge_api.dart';
import 'package:http/http.dart' as http;

class ParkList extends StatelessWidget {
  final TCardController _controller = TCardController();
  final DogeApi api = new DogeApi(httpClient: http.Client());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParkBloc, ParkState>(builder: (context, state) {
      switch (state.status) {
        case ParkStatus.failure:
          return const Center(
            child: Text('failed to fetch doges'),
          );
        case ParkStatus.success:
          if (state.dogeImageUrls.isEmpty) {
            return const Center(
              child: Text('no doges'),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TCard(
                controller: _controller,
                onForward: (index, info) {
                  print('Moving forward on $index');
                  BlocProvider.of<ParkBloc>(context).add(
                    DogeDecision(
                      imageUrl: state.dogeImageUrls[info.cardIndex],
                      decision: info.direction == SwipDirection.Right,
                    ),
                  );
                },
                onEnd: () {
                  BlocProvider.of<ParkBloc>(context).add(
                    ParkDogeArrival(),
                  );
                  _controller.reset(
                    cards: _generateCards(
                      state.dogeImageUrls,
                    ),
                  );
                },
                cards: _generateCards(state.dogeImageUrls),
                // size: Size(400, 600),
              ),
              ParkFilter(),
            ],
          );
        default:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }

  List<Widget> _generateCards(List<String> imageList) {
    return List.generate(
      imageList.length,
      (int index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 17),
                blurRadius: 23.0,
                spreadRadius: -13.0,
                color: Colors.black54,
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.network(
              imageList[index],
              fit: BoxFit.contain,
            ),
          ),
        );
      },
      growable: true,
    );
  }
}
