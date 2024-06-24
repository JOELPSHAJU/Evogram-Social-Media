part of 'get_connections_bloc.dart';

@immutable
sealed class GetConnectionsState {}

final class GetConnectionsInitial extends GetConnectionsState {}

final class GetConnectionsLoadingState extends GetConnectionsState {}

final class GetConnectionsSuccesfulState extends GetConnectionsState {
  final int followersCount;
  final int followingsCount;

  GetConnectionsSuccesfulState(
      {required this.followersCount, required this.followingsCount});
}

final class GetConnectionsErrorState extends GetConnectionsState {}
