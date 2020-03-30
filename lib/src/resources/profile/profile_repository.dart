import 'package:covidapp/src/models/profile.dart';

abstract class ProfileRepository {
  Future save({Profile profile});

  Future<Profile> get({String uid});
}
