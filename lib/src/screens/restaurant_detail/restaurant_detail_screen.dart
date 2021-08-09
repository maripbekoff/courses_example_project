import 'package:cached_network_image/cached_network_image.dart';
import 'package:courses_example_project/src/common/models/remote/image_model.dart';
import 'package:courses_example_project/src/common/widgets/custom_back_arrow_widget.dart';
import 'package:courses_example_project/src/common/widgets/text_field_divider.dart';
import 'package:courses_example_project/src/constants/color_const.dart';
import 'package:courses_example_project/src/constants/padding_const.dart';
import 'package:courses_example_project/src/constants/text_style_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/restaurant_detail_bloc.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: BlocBuilder<RestaurantDetailBloc, RestaurantDetailState>(
        builder: (context, state) {
          if (state is RestaurantDetailLoading) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is RestaurantDetailLoaded) {
            return ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                Stack(
                  children: [
                    SingleChildScrollView(
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (ImageModel image in state.rest.images)
                            CachedNetworkImage(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                              imageUrl: state.rest.images.isNotEmpty
                                  ? image.url
                                  : 'https://cdn.iconscout.com/icon/free/png-256/data-not-found-1965034-1662569.png',
                            )
                        ],
                      ),
                    ),
                    Container(
                      height: kToolbarHeight * 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            CupertinoColors.black.withOpacity(.8),
                            CupertinoColors.black.withOpacity(0),
                          ],
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomBackArrow(
                            color: AppColors.white,
                          ),
                          Text(
                            state.rest.title,
                            style: TextStyle(color: AppColors.white),
                          ),
                          CupertinoButton(
                            child: Icon(
                              CupertinoIcons.heart,
                              color: AppColors.white,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: AppPaddings.primary,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Описание',
                        style: descriptionTitleTextStyle,
                      ),
                      SizedBox(height: 3),
                      Text(
                        state.rest.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: descriptionTextStyle,
                      ),
                      SizedBox(height: 5),
                      CupertinoButton(
                        onPressed: () {},
                        minSize: 0,
                        padding: EdgeInsets.zero,
                        child: Text(
                          'Подробнее',
                          style: TextStyle(
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TextFieldDivider(),
                Padding(
                  padding: AppPaddings.primary,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.clock,
                            color: CupertinoColors.black,
                            size: 16,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Работаем с ${state.rest.schedule.opening} до ${state.rest.schedule.closing}',
                          ),
                        ],
                      ),
                      SizedBox(height: 14),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.map_pin,
                            color: CupertinoColors.black,
                            size: 16,
                          ),
                          SizedBox(width: 12),
                          Text(state.rest.coords.addressName),
                        ],
                      ),
                    ],
                  ),
                ),
                TextFieldDivider(),
              ],
            );
          }
          return Offstage();
        },
      ),
    );
  }
}
