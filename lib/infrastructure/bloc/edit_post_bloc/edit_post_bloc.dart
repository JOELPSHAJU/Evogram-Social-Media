import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:evogram/domain/repository/user_post_repo.dart';
import 'package:evogram/presentation/edit_post/edit_post.dart';

import 'package:meta/meta.dart';

part 'edit_post_event.dart';
part 'edit_post_state.dart';

class EditPostBloc extends Bloc<EditPostEvent, EditPostState> {
  EditPostBloc() : super(EditPostInitial()) {
    on<EditPostEvent>(
      (event, emit) {},
    );
    on<EditPostClickEvent>(editpostevent);
  }
  Future<void> editpostevent(
      EditPostClickEvent event, Emitter<EditPostState> emit) async {
    emit(EditPostLoadingState());
    final response =
          await PostRepo.editpost(description: event.description, postid: event.postid,image:pickEditImage.value,imageurl: event.imageurl );
      if (response != null && response.statusCode == 200) {
        return emit(EditPostSuccessState());
      } else if (response != null) {
        final responseData = jsonDecode(response.body);
        return emit(EditPostErrorState(error: responseData["message"]));
      } else {
        return emit(EditPostErrorState(error: 'something went wrong'));
      }
  }
}
