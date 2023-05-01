import 'bloc_status.dart';

class BaseState {
  const BaseState({
    this.status = BlocStatus.initial,
    this.message,
  });

  final BlocStatus status;
  final String? message;

  bool get isLoading {
    return status == BlocStatus.loading;
  }

  bool get isSuccess {
    return status == BlocStatus.success;
  }
}
