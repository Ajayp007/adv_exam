import 'dart:convert';

import 'package:adv_exam/screen/home/model/home_model.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  Future<JokesModel?>? getJokesAPI() async {
    String jokes =
        "https://api.chucknorris.io/jokes/random?_gl=1*u1rwjr*_ga*NTk0NTM5OTc1LjE3MTg1OTk2NzU.*_ga_ZCYG64C7PL*MTcxODU5OTY3NC4xLjEuMTcxODU5OTY3Ni4wLjAuMA..";

    var response = await http.get(Uri.parse(jokes));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      JokesModel model = JokesModel.mapToModel(json);
      return model;
    }
    return null;
  }
}
