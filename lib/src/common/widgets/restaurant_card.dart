import 'package:cached_network_image/cached_network_image.dart';
import 'package:courses_example_project/src/common/models/local/restaurant_detail_screen_args.dart';
import 'package:courses_example_project/src/common/models/remote/restaurant_model.dart';
import 'package:courses_example_project/src/constants/border_radius_const.dart';
import 'package:courses_example_project/src/constants/color_const.dart';
import 'package:courses_example_project/src/constants/padding_const.dart';
import 'package:courses_example_project/src/routes/routing_const.dart';
import 'package:courses_example_project/src/screens/home/cubits/favourites/favourites_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    Key? key,
    required this.rest,
  }) : super(key: key);

  final RestaurantModel rest;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        RestaurantDetailRoute,
        arguments: RestaurantDetailScreenArgs(
          id: rest.id,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppBorderRadius.primary,
          color: Color(0xFFFEFEFE),
        ),
        child: Column(
          children: [
            Container(
              height: 150,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: AppBorderRadius.primary,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    rest.images.isNotEmpty
                        ? rest.images.first.url
                        : 'https://cdn.iconscout.com/icon/free/png-256/data-not-found-1965034-1662569.png',
                  ),
                ),
              ),
            ),
            Padding(
              padding: AppPaddings.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rest.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          rest.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.inActive,
                          ),
                        ),
                        Text(
                          rest.coords.addressName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.inActive,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CupertinoButton(
                    minSize: 0,
                    padding: EdgeInsets.only(top: 10),
                    child: rest.isFavourite
                        ? Icon(
                            CupertinoIcons.heart_fill,
                            color: AppColors.red,
                          )
                        : Icon(
                            CupertinoIcons.heart,
                            color: AppColors.red,
                          ),
                    onPressed: () =>
                        context.read<FavouritesCubit>().addFavourite(
                              rest.id,
                            ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
