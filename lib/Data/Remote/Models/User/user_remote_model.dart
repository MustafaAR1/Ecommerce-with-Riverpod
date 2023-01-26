import 'package:google_sign_in/google_sign_in.dart';

class UserModelRemote {
  late String displayName;
  late String email;
  late String id;
  String? photoUrl;
  String? serverAuthCode;

  UserModelRemote({
    required this.displayName,
    required this.email,
    required this.id,
    this.photoUrl,
    this.serverAuthCode,
  });

  UserModelRemote.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    email = json['email'];
    id = json['id'];
    photoUrl = json['photoUrl'];
    serverAuthCode = json['serverAuthCode'];
  }
  UserModelRemote.fromObject(GoogleSignInAccount user) {
    displayName = user.displayName.toString();
    email = user.email.toString();
    id = user.id;
    photoUrl = user.photoUrl;
    serverAuthCode = user.serverAuthCode;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['displayName'] = displayName;
    data['email'] = email;
    data['id'] = id;
    data['photoUrl'] = photoUrl;
    data['serverAuthCode'] = serverAuthCode;
    return data;
  }
}
