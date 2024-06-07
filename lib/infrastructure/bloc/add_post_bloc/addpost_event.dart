part of 'addpost_bloc.dart';

@immutable
sealed class AddpostEvent {}
final class OnPostButtonClickedEvent extends AddpostEvent {
  final String imagePath;
  final String description;

  OnPostButtonClickedEvent(
      {required this.imagePath, required this.description});
}
