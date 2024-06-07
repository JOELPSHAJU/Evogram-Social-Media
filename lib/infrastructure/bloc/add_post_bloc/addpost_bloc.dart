// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:evogram/domain/repository/user_post_repo.dart';
import 'package:meta/meta.dart';

part 'addpost_event.dart';
part 'addpost_state.dart';

class AddpostBloc extends Bloc<AddpostEvent, AddpostState> {
  AddpostBloc() : super(AddpostInitial()) {
    on<OnPostButtonClickedEvent>((event, emit) async {
      emit(AddPostLoadingstate());
      final response =
          await PostRepo.addPost(event.description, event.imagePath);
      if (response != null && response.statusCode == 200) {
        emit(AddPostSuccesState());
      } else if (response != null) {
        emit(AddPostErrorState(
            error: 'something went wrong ${response.statusCode}'));
      } else {
        emit(AddPostErrorState(error: 'unknown error'));
      }
    });
  }
}
