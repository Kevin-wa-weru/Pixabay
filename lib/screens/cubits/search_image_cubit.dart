import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_challenge/services/pixabay_service.dart';

class SearchImagesCubit extends Cubit<SearchImagesState> {
  final PixabayService pixabayService;

  SearchImagesCubit({required this.pixabayService})
      : super(SearchImagesInitial());

  Future<void> searchImages(String query) async {
    if (query.isEmpty) {
      emit(SearchImagesInitial());
      return;
    }

    emit(SearchImagesLoading());
    try {
      final images = await pixabayService.searchImages(query);
      if (images.isEmpty) {
        emit(SearchImagesEmpty());
      } else {
        emit(SearchImagesSuccess(images: images));
      }
    } catch (e) {
      emit(SearchImagesError(error: e.toString()));
    }
  }
}

abstract class SearchImagesState {}

class SearchImagesInitial extends SearchImagesState {}

class SearchImagesLoading extends SearchImagesState {}

class SearchImagesSuccess extends SearchImagesState {
  final List<dynamic> images;
  SearchImagesSuccess({required this.images});
}

class SearchImagesEmpty extends SearchImagesState {}

class SearchImagesError extends SearchImagesState {
  final String error;
  SearchImagesError({required this.error});
}
