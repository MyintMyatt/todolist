import 'package:get_storage/get_storage.dart';

class GetStorageService{
  static final _storage = GetStorage();

  static dynamic get storage {return _storage;}
}