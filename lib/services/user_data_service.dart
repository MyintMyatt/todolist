import 'package:todolists/models/app_user_data.dart';
import 'package:todolists/services/storage_service.dart';

class UserService {
  final _storage = GetStorageService.storage;
  final _userKey = 'user_profile';

  saveUser(AppUserData user) {
    _storage.wirte(_userKey, user.toJson());
  }

  AppUserData get loadUser{
    Map<String, dynamic> user = _storage.read(_userKey);
    return AppUserData(userName: user['userName'], gender: user['gender'], occupation: user['occupation'], birthday: user['birthday'], age: user['age']);
  }
}
