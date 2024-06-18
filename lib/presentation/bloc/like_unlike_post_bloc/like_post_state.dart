part of 'like_post_bloc.dart';

@immutable
sealed class LikePostState {}

final class LikePostInitial extends LikePostState {}

final class LikePostNotFoundState extends LikePostState {}

final class LikePostLoadingState extends LikePostState {}

final class LikePostAlreadyLikedState extends LikePostState {}

final class LikePostSuccesfulState extends LikePostState {}

final class LikePostServerErrorState extends LikePostState {}

final class UnlikePostLoadingState extends LikePostState {}

final class UnlikePostNotFoundState extends LikePostState {}

final class UnlikePostUserNotLikedPostState extends LikePostState {}

final class UnlikePostServerErrorState extends LikePostState {}

final class UnlikePostSuccesfulState extends LikePostState {}
