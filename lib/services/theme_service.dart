import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todolists/services/storage_service.dart';

class ThemeService {
  final _storage = GetStorageService.storage;
  final _themeKey = 'isDarkMode';

  bool get loadThemeMode => _storage.read(_themeKey) ?? false;

  ThemeMode get thememode => loadThemeMode ? ThemeMode.dark : ThemeMode.light;

  _saveThemeMode(bool isDarkMode) {
    print(_storage.runtimeType);
    _storage.write(_themeKey, isDarkMode);
  }

  switchThemeMode() {
    _saveThemeMode(!loadThemeMode);
    print(loadThemeMode ? 'Dark' : 'Light');
    Get.changeThemeMode(loadThemeMode ? ThemeMode.dark : ThemeMode.light);
  }
}
