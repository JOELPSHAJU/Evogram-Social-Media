part of 'fetch_post_bloc.dart';

@immutable
sealed class FetchPostEvent {}
class FetchPostInitialEvent extends FetchPostEvent{}