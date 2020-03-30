import 'package:bloc/bloc.dart';
import 'package:covidapp/src/resources/profile/profile_repository.dart';
import 'package:flutter/widgets.dart';

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileBloc({@required ProfileRepository profileRepository})
      : assert(profileRepository != null),
        _profileRepository = profileRepository;

  @override
  ProfileState get initialState => ProfileInitial();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileSavePressed) {
      yield* _mapProfileSavePressedToState(event);
    }
  }

  Stream<ProfileState> _mapProfileSavePressedToState(ProfileSavePressed event) async* {
    yield ProfileSaveInProgress();
    try {
      await _profileRepository.save(profile: event.profile);
      yield ProfileSaveSuccess();
    } catch (_) {
      print(_);
      yield ProfileFailure();
    }
  }
}
