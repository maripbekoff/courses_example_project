import 'package:courses_example_project/src/common/dio/app_dio.dart';
import 'package:courses_example_project/src/common/models/remote/restaurant_model.dart';
import 'package:dio/dio.dart';

abstract class RestaurantService {
  Future<List<RestaurantModel>> getRestaurants({int? page, int? limit});
  Future<RestaurantModel> getRestaurant({required int id});
}

class RestaurantServiceImpl implements RestaurantService {
  late Dio dio;

  RestaurantServiceImpl({required AppDio appDio}) {
    appDio.path = 'restaurants/';
    this.dio = appDio.dio;
  }

  @override
  Future<List<RestaurantModel>> getRestaurants({int? page, int? limit}) async {
    try {
      Response response = await dio.get('all', queryParameters: {
        'page': page,
        'perPage': limit,
      });
      return (response.data['restaurants'] as List)
          .map((e) => RestaurantModel.fromJson(e))
          .toList();
    } on DioError catch (e) {
      throw e;
    }
  }

  @override
  Future<RestaurantModel> getRestaurant({required int id}) async {
    try {
      Response response = await dio.get('details/$id');
      return RestaurantModel.fromJson(response.data['restaurant'].first);
    } on DioError catch (e) {
      throw e;
    }
  }
}
