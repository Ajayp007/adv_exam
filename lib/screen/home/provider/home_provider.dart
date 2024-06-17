import 'package:adv_exam/screen/home/model/home_model.dart';
import 'package:adv_exam/utils/helper/api_helper.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  ApiHelper helper = ApiHelper();
  Future<JokesModel?>? model;
  List<JokesModel> likeList = [];
  int? deleteJokes;

  void getJokesApi() {
    model = helper.getJokesAPI();

    model!.then(
      (value) {
        if (value != null) {
          notifyListeners();
        }
      },
    );
  }

  void addLikeJokes(JokesModel model) {
    likeList.add(model);
    notifyListeners();
  }

  void removeJokes(int index) {
    likeList.removeAt(index);
    notifyListeners();
  }
}
