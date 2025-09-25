import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_challenge/screens/cubits/get_trending_images_cubit.dart';
import 'package:web_challenge/screens/cubits/search_image_cubit.dart';
import 'package:web_challenge/screens/cubits/update_profile_cubit.dart';
import 'package:web_challenge/services/pixabay_service.dart';
import 'package:web_challenge/services/profie_service.dart';

class Singletons {
  static final PixabayService _pixabayService = PixabayService();
  static final ProfileService _profileService = ProfileService();

  static List<BlocProvider> registerCubits() => [
    BlocProvider<TrendingImagesCubit>(
      create: (context) => TrendingImagesCubit(pixabayService: _pixabayService),
    ),
    BlocProvider<SearchImagesCubit>(
      create: (context) => SearchImagesCubit(pixabayService: _pixabayService),
    ),
    BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit(profileService: _profileService),
    ),
  ];
}
