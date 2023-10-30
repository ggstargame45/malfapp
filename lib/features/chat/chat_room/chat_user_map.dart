


import 'package:malf/features/profile/profile_model.dart';

class UserMap{
  static final UserMap _singletonModel = UserMap._internal();
  Map<String,ProfileData> userMap = {};
  //user_uniq_id : {nickname, profile_image link}
  factory UserMap() => _singletonModel;
  UserMap._internal();
}