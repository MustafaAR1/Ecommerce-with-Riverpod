import 'package:google_sign_in/google_sign_in.dart';
import 'package:isar/isar.dart';

part 'user_local_model.g.dart';

@collection
class UserLocalModel {
  Id? id;

  late String displayName;
  late String email;
//  late String id;
  String? photoUrl;
  String? serverAuthCode;
  UserLocalModel();

  UserLocalModel.fromObject(GoogleSignInAccount user) {
    displayName = user.displayName.toString();
    email = user.email.toString();
    id = id;
    photoUrl = user.photoUrl;
    serverAuthCode = user.serverAuthCode;
  }
}
