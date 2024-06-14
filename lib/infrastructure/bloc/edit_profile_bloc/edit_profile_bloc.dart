import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:evogram/domain/repository/user_repo.dart';
import 'package:evogram/presentation/userprofile/edit_profile/edit_profile.dart';
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
    final response = await LoginUserRepo.editprofile(
        image:profileimageeditprofile.value ,
        backgroundImageurl: event.backgroundImageurl,
        backgroundImage: coverimageeditprofile.value,
        imageurl: event.imageurl,
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
