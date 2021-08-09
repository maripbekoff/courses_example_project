import 'package:courses_example_project/src/common/dependencies/injection_container.dart';
import 'package:courses_example_project/src/routes/router.dart';
import 'package:courses_example_project/src/screens/favourites/bloc/favourites_bloc.dart';
import 'package:courses_example_project/src/screens/favourites/favourites_screen.dart';
import 'package:courses_example_project/src/screens/home/bloc/home_bloc.dart';
import 'package:courses_example_project/src/screens/home/home_screen.dart';
import 'package:courses_example_project/src/screens/map/bloc/map_bloc.dart';
import 'package:courses_example_project/src/screens/map/map_screen.dart';
import 'package:courses_example_project/src/screens/profile/profile_screen.dart';
import 'package:courses_example_project/src/screens/register/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          border: Border(),
          inactiveColor: CupertinoColors.black,
          items: [
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.map)),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.heart)),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled)),
          ],
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            onGenerateRoute: AppRouter.generateRoute,
            builder: (context) {
              switch (index) {
                case 0:
                  return BlocProvider(
                    create: (context) => HomeBloc(
                      restaurantService: getIt(),
                    )..add(InitHome()),
                    child: HomeScreen(),
                  );
                case 1:
                  return BlocProvider(
                    create: (context) => MapBloc(
                      restaurantService: getIt(),
                    )..add(InitMap()),
                    child: MapScreen(),
                  );
                case 2:
                  return BlocProvider(
                    create: (context) => FavouritesBloc(
                      favouriteService: getIt(),
                    )..add(InitFavourites()),
                    child: FavouritesScreen(),
                  );
                case 3:
                  return ProfileScreen();
                default:
                  return RegisterScreen();
              }
            },
          );
        },
      ),
    );
  }
}
