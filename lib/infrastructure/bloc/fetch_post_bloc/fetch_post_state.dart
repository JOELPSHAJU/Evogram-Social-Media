part of 'fetch_post_bloc.dart';

@immutable
sealed class FetchPostState {}

final class FetchPostInitial extends FetchPostState {}

final class FetchPostLoadingState extends FetchPostState {}

final class FetchPostSuccessState extends FetchPostState {
  final List<Postmodel> posts;

  FetchPostSuccessState({required this.posts});
}
final class FetchPostErrorStateInternalserverError extends FetchPostState{}
final class FetchPostErrorState extends FetchPostState{}