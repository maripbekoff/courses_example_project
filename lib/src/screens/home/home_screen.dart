import 'package:courses_example_project/src/common/widgets/restaurant_card.dart';
import 'package:courses_example_project/src/common/widgets/search_bar_widget.dart';
import 'package:courses_example_project/src/constants/padding_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: AppPaddings.horizontal,
              child: SearchBarWidget(),
            ),
            SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return Center(
                      child: CupertinoActivityIndicator(),
                    );
                  } else if (state is HomeLoaded) {
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: state.rests.length,
                      padding: AppPaddings.horizontal.copyWith(bottom: 100),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 20),
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
            ),
          ],
        ),
      ),
    );
  }
}
