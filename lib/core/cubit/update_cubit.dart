import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_update/in_app_update.dart';

import '../services/update_service.dart';

/// Cubit for managing app updates
class UpdateCubit extends Cubit<UpdateState> {
  final AppUpdateService _updateService;

  UpdateCubit(this._updateService) : super(const UpdateState.initial());

  /// Check for updates on app start
  Future<void> checkForUpdates() async {
    emit(const UpdateState.checking());

    try {
      final AppUpdateInfo? updateInfo = await _updateService.checkForUpdate();

      if (updateInfo != null && updateInfo.updateAvailability.value == 2) {
        emit(UpdateState.available());
        return;
      }
      emit(const UpdateState.notAvailable());
    } catch (e) {
      emit(const UpdateState.notAvailable());
    }
  }

  /// Start the update process
  Future<void> startUpdate() async {
    // emit(const UpdateState.updating());

    try {
      // if (type == UpdateType.immediate) {
      //   await _updateService.startImmediateUpdate();
      // } else {
      //   await _updateService.startFlexibleUpdate();
      // }

      // emit(const UpdateState.completed());

      await _updateService.startImmediateUpdate();
    } catch (e) {
      debugPrint('Error caught while updating: $e');
      emit(const UpdateState.notAvailable());
    }
  }

  // /// Dismiss update notification (for flexible updates)
  // void dismissUpdate() {
  //   emit(const UpdateState.dismissed());
  // }
}

/// State for app updates
class UpdateState extends Equatable {
  final UpdateStatus status;
  // final UpdateType? updateType;
  final String? errorMessage;

  const UpdateState({
    required this.status,
    // this.updateType,
    this.errorMessage,
  });

  const UpdateState.initial()
      : status = UpdateStatus.initial,
        // updateType = null,
        errorMessage = null;

  const UpdateState.checking()
      : status = UpdateStatus.checking,
        // updateType = null,
        errorMessage = null;

  // const UpdateState.available(UpdateType type)
  //     : status = UpdateStatus.available,
  //       updateType = type,
  //       errorMessage = null;

  const UpdateState.available()
      : status = UpdateStatus.available,
        errorMessage = null;

  const UpdateState.notAvailable()
      : status = UpdateStatus.notAvailable,
        // updateType = null,
        errorMessage = null;

  // @override
  // List<Object?> get props => [status, updateType, errorMessage];

  @override
  List<Object?> get props => [status, errorMessage];
}

/// Enum for update status
enum UpdateStatus {
  initial,
  checking,
  available,
  notAvailable,
}
