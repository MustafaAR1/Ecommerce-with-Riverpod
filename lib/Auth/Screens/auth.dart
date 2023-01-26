import 'package:ecommerce_app/Controllers/Providers/providers.dart';
import 'package:ecommerce_app/Products/Screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../Data/Local/Models/User/user_local_model.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final googleSignIn = ref.read(googleProvider);
    final localdb = ref.read(isarProvider);

    return Scaffold(
        body: SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const FlutterLogo(size: 100),
          ElevatedButton(
              style: const ButtonStyle(),
              onPressed: () async {
                //   googleLogin() async {
                try {
                  GoogleSignInAccount? result = await googleSignIn
                      .signIn()
                      .then((value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProductScreen())));
                  // print('RESULT: ${result?.email}');

                  localdb.openDb();
                  localdb.saveUser(UserLocalModel.fromObject(result!));

                  // var databasePath =
                  //     (await getApplicationDocumentsDirectory()).path;
                  // final isar = await Isar.open(
                  //   [UserLocalModelSchema],
                  //   //directory: databasePath
                  // );
                  //final users =
                  // await isar.writeTxn(() async {
                  //   isar.userLocalModels.put(UserLocalModel.fromObject(result));
                  // });

                  //    isar.userLocalModels.put(UserLocalModel.fromObject(result));
                  //     inspect(isar.userLocalModels);
                  //  await   isar.writeTxn(() {
                  //     isar.userModelLocals.put();
                  //  })
                  //   inspect(isar.userLocalModels);

                  //var serverToken = await result.authentication;

                  // UserModel _user =
                  //     UserModel.fromJson( jsonDecode(result!['GoogleSignInAccount']));
                  //final ggAuth = await result.authentication;
                  //    Map<String, String> headers = await result.authHeaders;
                  // inspect(headers);
                  // String accessToken =
                  //     'ya29.a0AX9GBdVQN1egWjS1Qc9WsLK2sSRSFwcjMAg58P4AXQQWs3P2_0UMqHScZiUZIgyaA5ATzxOUoT0x-csMniGU_JeHuCp0tnpyzwnZHZBugS9kmxAIPTdB7Q8bHx5-tcriPdPZlVHNZRdSr-9rN4WFxROhnpE1aCgYKAd8SARASFQHUCsbCwUnwyyQne7D3IAPrNQdW0g0163';
                  // var response = await Dio().get(
                  //   'https://www.googleapis.com/calendar/v3/calendars/primary/events',
                  //   options: Options(
                  //     headers: {'Authorization': 'Bearer $accessToken'},
                  //   ),

                  // print('RESPONSE: ${response}');
                  //print(serverToken.accessToken);
                } catch (e) {
                  //    }
                }
              },
              child: const Text('Login With Google')),
          ElevatedButton(
              style: const ButtonStyle(),
              onPressed: () async {
                //   googleLogin() async {
                try {
                  final googleSignIn = GoogleSignIn();
                  var result = await googleSignIn.signOut();
                } catch (e) {
                  //    }
                }
              },
              child: const Text('Signout')),
          ElevatedButton(
              style: const ButtonStyle(),
              onPressed: () async {
                await localdb
                    .getAllUsers()
                    .then((value) => print(value[0].displayName));
                //   googleLogin() async {
                // try {
                //   print("googleLogin method Called");
                //   final _googleSignIn = GoogleSignIn();
                //   var result = await _googleSignIn.signOut();
                //   print("Result ${result}");
                // } catch (e) {
                //   print(e);
                //   //    }
                // }
              },
              child: const Text('db test'))
        ],
      ),
    ));
  }
}
