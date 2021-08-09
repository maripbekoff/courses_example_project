import 'package:courses_example_project/src/common/models/remote/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(UserModelAdapter());

  await Hive.openBox('tokens');
  await Hive.openBox<UserModel>('user');
}
