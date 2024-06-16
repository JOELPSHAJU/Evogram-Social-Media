import 'dart:convert';


import 'package:bloc/bloc.dart';
import 'package:evogram/domain/repository/user_repo.dart';

import 'package:meta/meta.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<EditProfileEvent>((event, emit) {});
    on<EditprofileClickEvent>(editprofileevent);
  }
  Future<void> editprofileevent(
      EditprofileClickEvent event, Emitter<EditProfileState> emit) async {
    emit(EditProfileLoadingState());
    final response = await LoginUserRepo.editProfile(
        image: event.image,
        bgImageUrl: event.bgImageUrl,
        bgImage: event.bgImage,
        imageUrl: event.imageUrl,
        name: event.name,
        bio: event.bio);

    if (response != null && response.statusCode == 200) {
      return emit(EditProfileSuccessState());
    } else if (response != null) {
      final responseData = jsonDecode(response.body);
      return emit(EditProfileErrorState(error: responseData["message"]));
    } else {
      return emit(EditProfileErrorState(error: 'something went wrong'));
    }
  }
}
