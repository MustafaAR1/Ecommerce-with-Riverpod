import 'package:ecommerce_app/Controllers/Services/IsarServices/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Controllers/Providers/providers.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _localdb = ref.read(isarProvider);
    final _userdb = ref.read(userProvider);

    // print('_LOCALDB: ${_localdb.getAllUsers()}');
    return Scaffold(
        appBar: AppBar(
          actions: [
            // CircleAvatar(
            //   backgroundImage: NetworkImage(_localdb.getAllUsers()),
            // )
          ],
        ),
        body: _userdb.when(
            loading: () => const Center(
                  child: Text("Loading"),
                ),
            error: (error, stackTrace) => Text(error.toString()),
            data: (data) => Center(
                  child: Text(data[0].displayName),
                )));
  }
}
