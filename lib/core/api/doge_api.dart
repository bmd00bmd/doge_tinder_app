import 'dart:collection';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'package:doge_tinder_app/core/models/models.dart';

const String domain = 'dog.ceo';

class DogeApi {
  const DogeApi({required this.httpClient});
  final http.Client httpClient;

  Future<dynamic> fetchRandomDogeImages([int limit = 1]) async {
    String resource = '/api/breeds/image/random/$limit';
    final response = await httpClient.get(Uri.https(domain, resource));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
  }

  Future<dynamic> fetchFilteredBreedImages(
      [String breed = 'hound', int limit = 1]) async {
    String resource = '/api/breed/$breed/images/random/$limit';
    final response = await httpClient.get(Uri.https(domain, resource));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
  }

  Future<dynamic> fetchFilteredSubBreedImages(
      [String breed = 'hound',
      String subBreed = 'afghan',
      int limit = 1]) async {
    String resource = '/api/breed/$breed/$subBreed/images/random/$limit';
    final response = await httpClient.get(Uri.https(domain, resource));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
  }

  Future<List<DogeBreed>> fetchAllBreeds(
      [String breed = '', String subBreed = '']) async {
    final response = await httpClient.get(
      Uri.https(domain, '/api/breeds/list/all'),
    );
    List<DogeBreed> breeds = [];
    if (response.statusCode == 200) {
      final body =
          json.decode(response.body)['message'] as Map<String, dynamic>;
      ;
      body.forEach((key, value) {
        breeds.add(
          DogeBreed(
            name: key,
            subBreedNames: List<String>.from(value),
          ),
        );
      });
    }
    return breeds;
  }
}
