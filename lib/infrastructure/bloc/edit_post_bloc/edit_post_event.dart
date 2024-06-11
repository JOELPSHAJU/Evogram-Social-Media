part of 'edit_post_bloc.dart';

@immutable
sealed class EditPostEvent {}

final class EditPostClickEvent extends EditPostEvent{
    final String image;
  final String imageurl;
  final String description;
  final String postid;

  EditPostClickEvent({required this.image, required this.imageurl, required this.description, required this.postid});
}