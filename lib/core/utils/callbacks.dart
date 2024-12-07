import 'package:montra_clone/core/utils/custom_snackbar.dart';

import '../error/exceptions.dart';
import '../utils/devlog.dart';

typedef BoolCallback = Future<bool> Function();

Future<T> repoCallback<T>({
  required String name,
  required Future<T> Function() callback,
}) async {
  try {
    return await callback();
  } on ServerException catch (e) {
    devlogError("ERROR IN REPO : SERVER EXCEPTION -> $name : ${e.message}");
    throw ServerException(e.message);
  } catch (e) {
    devlogError("ERROR IN REPO : CATCH ERROR -> $name : $e");
    throw ServerException("Something went wrong.!");
  }
}

Future<bool> apiCallback({
  required String name,
  bool isNetwork = true,
  required BoolCallback doWhenOnline,
  BoolCallback? doWhenOffline,
}) async {
  bool isSuccess = false;
  try {
    if (isNetwork) {
      isSuccess = await doWhenOnline();
      if (isSuccess) {
        devlog("SUCCESS MESSAGE - PROVIDER -> $name ");
      }
    } else {
      showToast(message: "No Internet Connection.!");
      if (doWhenOffline != null) {
        isSuccess = await doWhenOffline();
      }
    }
  } on ServerException catch (e) {
    devlogError("ERROR - PROVIDER - SERVER_EXCEPTION -> $name : $e");
    showToast(message: e.message);
  } catch (e) {
    devlogError("ERROR - PROVIDER - CATCH_ERROR -> $name : $e");
    showToast(message: "Something went wrong.!");
  }
  return isSuccess;
}
