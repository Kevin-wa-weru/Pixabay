import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_challenge/services/pixabay_service.dart';

class TrendingImagesCubit extends Cubit<TrendingImagesState> {
  final PixabayService pixabayService;

  TrendingImagesCubit({required this.pixabayService})
      : super(TrendingImagesInitial());

  Future<void> fetchTrendingImages() async {
    emit(TrendingImagesLoading());
    try {
      final images = await pixabayService.fetchTrendingImages();
      if (images.isEmpty) {
        emit(TrendingImagesEmpty());
      } else {
        emit(TrendingImagesSuccess(images: images));
      }
    } catch (e) {
      emit(TrendingImagesError(error: e.toString()));
    }
  }
}

abstract class TrendingImagesState {}

class TrendingImagesInitial extends TrendingImagesState {}

class TrendingImagesLoading extends TrendingImagesState {}

class TrendingImagesSuccess extends TrendingImagesState {
  final List<dynamic> images;
  TrendingImagesSuccess({required this.images});
}

class TrendingImagesEmpty extends TrendingImagesState {}

class TrendingImagesError extends TrendingImagesState {
  final String error;
  TrendingImagesError({required this.error});
}
