import 'package:flutter/foundation.dart';
import 'package:in_app_update/in_app_update.dart';

/// Service to handle Google Play In-App Updates
class AppUpdateService {
  /// Check if an update is available
  Future<AppUpdateInfo?> checkForUpdate() async {
    try {
      // Only works on Android with Google Play Services
      if (defaultTargetPlatform != TargetPlatform.android) {
        return null;
      }

      final AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();
      return updateInfo;
    } catch (e) {
      debugPrint('Error checking for update: $e');
      return null;
    }
  }

  // /// Start a flexible update (background download, user continues using app)
  // /// Best for minor updates
  // Future<void> startFlexibleUpdate() async {
  //   try {
  //     final AppUpdateInfo? updateInfo = await checkForUpdate();
  //
  //     if (updateInfo == null) return;
  //
  //     if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
  //       await InAppUpdate.startFlexibleUpdate();
  //
  //       // Listen to download progress
  //       InAppUpdate.completeFlexibleUpdate().then((_) {
  //         debugPrint('Flexible update completed');
  //       });
  //     }
  //   } catch (e) {
  //     debugPrint('Error starting flexible update: $e');
  //   }
  // }

  /// Start an immediate update (blocks app until update completes)
  /// Best for critical updates
  Future<void> startImmediateUpdate() async {
    try {
      final AppUpdateInfo? updateInfo = await checkForUpdate();

      if (updateInfo == null) return;

      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        if (updateInfo.immediateUpdateAllowed) {
          await InAppUpdate.performImmediateUpdate();
        }
      }
    } catch (e) {
      debugPrint('Error starting immediate update: $e');
    }
  }

  // /// Check if update is available and return type
  // Future<UpdateType?> getUpdateType() async {
  //   try {
  //     final AppUpdateInfo? updateInfo = await checkForUpdate();
  //
  //     if (updateInfo == null) return null;
  //
  //     if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
  //       // You can define your own logic for when to use immediate vs flexible
  //       // For example: immediate for major versions, flexible for minor
  //       if (updateInfo.immediateUpdateAllowed) {
  //         return UpdateType.immediate;
  //       } else if (updateInfo.flexibleUpdateAllowed) {
  //         return UpdateType.flexible;
  //       }
  //     }
  //
  //     return null;
  //   } catch (e) {
  //     debugPrint('Error getting update type: $e');
  //     return null;
  //   }
  // }
}

// /// Enum for update types
// enum UpdateType {
//   immediate, // Blocking update
//   flexible, // Background update
// }
