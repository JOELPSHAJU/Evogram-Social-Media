part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileEvent {}
final class EditprofileClickEvent extends EditProfileEvent {
  final String name;
  final String bio;
  final dynamic image;
  final String? imageUrl;
  final dynamic bgImage;
  final String? bgImageUrl;


  EditprofileClickEvent( 
      {required this.name,required this.bio,required this.imageUrl,required this.image,required this.bgImageUrl,required this.bgImage});
}