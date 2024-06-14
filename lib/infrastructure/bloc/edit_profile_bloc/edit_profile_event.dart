part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileEvent {}
final class EditprofileClickEvent extends EditProfileEvent {
  final String name;
  final String bio;
  final String imageurl;
  final String image;
  final String backgroundImageurl;
  final String backgroundImage;

  EditprofileClickEvent( 
      {required this.name,required this.bio,required this.imageurl,required this.image,required this.backgroundImageurl,required this.backgroundImage});
}