import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAsU-YFDaUfYIeB--a15_zu73-hOPO8Xmo",
            authDomain: "ffitness-9dde1.firebaseapp.com",
            projectId: "ffitness-9dde1",
            storageBucket: "ffitness-9dde1.appspot.com",
            messagingSenderId: "914753304850",
            appId: "1:914753304850:web:81521f214475f16f129bcb",
            measurementId: "G-MN9GYQWNYV"));
  } else {
    await Firebase.initializeApp();
  }
}
