import 'package:learn_unit_testing/user_model.dart';
import 'package:dio/dio.dart';

class UserRepository {
  final Dio dio;
  //static late dynamic response;
  UserRepository(this.dio);
  Future<UserModel> getUser() async {
    var response =
        await dio.get('https://jsonplaceholder.typicode.com/users/1');
    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load user');
    }
  }
}
