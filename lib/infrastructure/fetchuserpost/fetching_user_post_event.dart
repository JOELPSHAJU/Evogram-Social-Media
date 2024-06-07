part of 'fetching_user_post_bloc.dart';

@immutable
sealed class FetchingUserPostEvent {}

class FetchingUserpostInitialEvent extends FetchingUserPostEvent {}
final class DeletePostClickEvent extends FetchingUserPostEvent {
  final String postId;
  DeletePostClickEvent({required this.postId});
}
