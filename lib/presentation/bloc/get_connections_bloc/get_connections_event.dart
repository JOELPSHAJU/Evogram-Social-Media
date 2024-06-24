part of 'get_connections_bloc.dart';

@immutable
sealed class GetConnectionsEvent {}

class ConnectionsInitilFetchEvent extends GetConnectionsEvent {
  final String userId;

  ConnectionsInitilFetchEvent({required this.userId});
}
