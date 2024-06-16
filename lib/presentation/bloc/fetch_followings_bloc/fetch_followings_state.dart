part of 'fetch_followings_bloc.dart';

@immutable
sealed class FetchFollowingsState {}

final class FetchFollowingsInitial extends FetchFollowingsState {}

final class FetchFollowingsLoadingState extends FetchFollowingsState {}

final class FetchFollowingsSuccesfulState extends FetchFollowingsState {
  final FollowingModel followingsModel;

  FetchFollowingsSuccesfulState({required this.followingsModel});
}

final class FetchFollowingsErrorState extends FetchFollowingsState {}
