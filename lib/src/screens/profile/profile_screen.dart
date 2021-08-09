import 'package:cached_network_image/cached_network_image.dart';
import 'package:courses_example_project/src/common/models/remote/user_model.dart';
import 'package:courses_example_project/src/common/widgets/custom_navigation_bar.dart';
import 'package:courses_example_project/src/constants/color_const.dart';
import 'package:courses_example_project/src/routes/routing_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserModel? user = Hive.box<UserModel>('user').get('user');

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CustomNavigationBar(
        leading: null,
        title: 'Профиль',
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 32),
          CircleAvatar(
            backgroundColor: AppColors.white,
            radius: 36,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(360),
              child: CachedNetworkImage(
                imageUrl:
                    'https://mir-s3-cdn-cf.behance.net/projects/404/c33c1899224199.Y3JvcCwzMjMyLDI1MjgsMCww.jpg',
                width: 72,
                height: 72,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            user?.nickname ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12),
          Text(
            user?.email ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.inActive,
            ),
          ),
          SizedBox(height: 27),
          Container(
            color: AppColors.white,
            child: Column(
              children: [
                CupertinoButton(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Выход',
                      style: TextStyle(
                        color: AppColors.red,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    Box tokensBox = Hive.box('tokens');
                    tokensBox.delete('access');
                    tokensBox.delete('refresh');

                    Navigator.of(
                      context,
                      rootNavigator: true,
                    ).pushReplacementNamed(
                      AuthRoute,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
