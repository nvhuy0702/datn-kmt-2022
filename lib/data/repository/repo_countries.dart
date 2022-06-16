import 'dart:convert';

import 'package:app_datn_2022/data/model/countries.dart';
import 'package:http/http.dart' as http;
import '../API/api.dart';

abstract class CountriesRepository {
  Future<List<Data>?>  fetchDetails();
}

class CountriesRepo extends CountriesRepository {
  @override
  Future<List<Data>?> fetchDetails() async {
    final response = await http.get(Uri.parse(baseCountries));
    if (response.statusCode == 200) {
      return CountriesModel.fromJson(jsonDecode(response.body)).data;
    } else {
      throw Exception('Failed to load API data');
    }
  }
}
