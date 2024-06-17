import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  Future<void> setSharedData(String l1) async {
    SharedPreferences shr = await SharedPreferences.getInstance();

    shr.setString("like", l1);
  }

  Future<String> getSharedData() async {
    String? like;
    SharedPreferences shr = await SharedPreferences.getInstance();
    like = shr.getString("like")!;
    return like;
  }
}
