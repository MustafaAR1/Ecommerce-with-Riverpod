import 'package:isar/isar.dart';

import '../../../Data/Local/Models/User/user_local_model.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDb();
  }

  Future<Isar> openDb() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([UserLocalModelSchema], inspector: true);
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> saveUser(UserLocalModel userLocalModel) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.userLocalModels.putSync(userLocalModel));
  }

  Future<List<UserLocalModel>> getAllUsers() async {
    final isar = await db;
    return await isar.userLocalModels.where().findAll();
  }

//   Future<UserLocalModel> getUserProfilePic(
//       UserLocalModel userLocalModel) async {
//     final isar = await db;

//     final displayImage = await isar.userLocalModels
//         .filter()
//         .photoUrlContains((q) => q.idEqualTo(userLocalModel.displayName))
//         .findFirst();

//     return teacher; // String _image = "";
//     // getAllUsers().then((value) => value.map((e) {
//     //       return _image = e.displayName;
//     //     }));
// //    return _image;
//     // final isar = await db;
//     //return await isar.userLocalModels.get(1).then((value) => value!.photoUrl);
//   }
}
