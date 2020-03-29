import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import 'db_repository.dart';

class HiveRepositoryImpl implements DbRepository {
  Box _box;

  HiveRepositoryImpl({@required String tableName}) {
    _box = Hive.box(tableName);
    _box.toMap().forEach((k, v) => print("key:$k value:$v\n"));
  }

  @override
  Future<int> add(value) {
    return _box.add(value);
  }

  @override
  Future<void> delete(key) {
    return _box.delete(key);
  }

  @override
  Future<void> deleteAt(int index) {
    return _box.deleteAt(index);
  }

  @override
  get(key, {defaultValue}) {
    return _box.get(key, defaultValue: defaultValue);
  }

  @override
  getAt(int index) {
    return _box.getAt(index);
  }

  @override
  Future<void> put(key, value) {
    return _box.put(key, value);
  }

  @override
  Future<void> putAt(int index, value) {
    return _box.putAt(index, value);
  }
}
