import 'package:courses_example_project/src/common/dio/app_dio.dart';
import 'package:courses_example_project/src/common/models/remote/restaurant_model.dart';
import 'package:dio/dio.dart';

abstract class FavouritesService {
  Future<List<RestaurantModel>> getFavourites();
  Future<void> addFavourite({required int id});
}

class FavouritesServiceImpl implements FavouritesService {
  late Dio dio;

  FavouritesServiceImpl({required AppDio appDio}) {
    appDio.path = 'likes/';
    this.dio = appDio.dio;
  }

  @override
  Future<List<RestaurantModel>> getFavourites() async {
    try {
      Response response = await dio.get('all');
      return (response.data['restaurants'] as List)
          .map((e) => RestaurantModel.fromJson(e))
          .toList();
    } on DioError catch (e) {
      throw e;
    }
  }

  @override
  Future<void> addFavourite({required int id}) async {
    try {
      await dio.post('new', data: {
        'restaurant_id': id,
      });
    } on DioError catch (e) {
      throw e;
    }
  }
}
