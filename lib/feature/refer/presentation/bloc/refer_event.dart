part of 'refer_bloc.dart';

@immutable
sealed class ReferEvent {}

final class OnRefer extends ReferEvent {
  final ReferModel refer;

  OnRefer({required this.refer});
}

 class FetchRefer extends ReferEvent {
  final String userId;

  FetchRefer({required this.userId});
}

class FetchUserId extends ReferEvent{}
