part of 'refer_bloc.dart';

@immutable
sealed class ReferState {}

final class ReferInitial extends ReferState {}

final class ReferLoading extends ReferState {}

final class ReferCreatedSuccess extends ReferState {
  final String message;

  ReferCreatedSuccess(this.message);
}

final class ReferFailure extends ReferState {
  final String message;

  ReferFailure(this.message);
}

final class ReferLoadedSuccess extends ReferState {
  final List<ReferModel> refers;

  ReferLoadedSuccess(this.refers);
}
