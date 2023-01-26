import 'package:ecommerce_app/Controllers/Services/Interceptor/dio_client.dart';
import 'package:ecommerce_app/Controllers/Services/IsarServices/isar_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

// serverClientId:
//     "104243094660-7evtdgni8gspje7glgj8628ndd9vi593.apps.googleusercontent.com",
// scopes: [
//   "https://www.googleapis.com/auth/calendar",
// ],

final googleProvider = Provider<GoogleSignIn>(
  (ref) => GoogleSignIn(),
);

final isarProvider = Provider<IsarService>(
  ((ref) => IsarService()),
);

final dioClientProvider = Provider<DioClient>(
  (ref) => DioClient(), //  DioClient(),
);

final userProvider = FutureProvider(
  (ref) => IsarService().getAllUsers(),
);
