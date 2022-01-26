import 'package:courses_example_project/src/common/models/remote/restaurant_model.dart';
import 'package:courses_example_project/src/common/widgets/search_bar_widget.dart';
import 'package:courses_example_project/src/constants/color_const.dart';
import 'package:courses_example_project/src/constants/padding_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'bloc/map_bloc.dart';
import 'widgets/rounded_icon_button.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          BlocListener<MapBloc, MapState>(
            listener: (context, state) {
              if (state is MapLoaded) {
                Set<Marker> _markers = {};

                for (RestaurantModel rest in state.rests) {
                  _markers.add(
                    Marker(
                      markerId: MarkerId('${rest.id}'),
                      position: LatLng(
                        rest.coords.latitude,
                        rest.coords.longitude,
                      ),
                    ),
                  );
                }

                setState(() {
                  markers = _markers;
                });
              }
            },
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(43.229789, 76.901491),
                zoom: 10,
              ),
              zoomControlsEnabled: false,
              markers: markers,
              mapToolbarEnabled: false,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: RoundedIconButton(
              icon: Icon(
                CupertinoIcons.compass,
                color: CupertinoColors.black,
                size: 30,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: AppPaddings.horizontal.copyWith(top: 10),
              child: SearchBarWidget(
                backgroundColor: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
