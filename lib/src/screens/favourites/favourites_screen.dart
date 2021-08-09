import 'package:courses_example_project/src/common/widgets/custom_navigation_bar.dart';
import 'package:courses_example_project/src/common/widgets/restaurant_card.dart';
import 'package:courses_example_project/src/constants/padding_const.dart';
import 'package:courses_example_project/src/screens/favourites/bloc/favourites_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CustomNavigationBar(
        leading: null,
        title: 'Избранные',
      ),
      child: BlocBuilder<FavouritesBloc, FavouritesState>(
        builder: (context, state) {
          if (state is FavouritesLoading) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is FavouritesLoaded) {
            if (state.rests.isEmpty) {
              return Center(
                child: Text(
                  'Список избранных ресторанов пуст!',
                ),
              );
            }
            return ListView.separated(
              shrinkWrap: true,
              itemCount: state.rests.length,
              padding: AppPaddings.horizontal.copyWith(bottom: 100),
              separatorBuilder: (context, index) => SizedBox(height: 20),
              itemBuilder: (context, index) {
                return RestaurantCard(
                  rest: state.rests[index],
                );
              },
            );
          }
          return Offstage();
        },
      ),
    );
  }
}
