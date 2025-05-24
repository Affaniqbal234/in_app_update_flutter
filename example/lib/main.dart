import 'package:flutter/material.dart';
import 'package:in_app_update_flutter/in_app_update_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('In-App Update Example')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              await InAppUpdateFlutter().showUpdate(appStoreId: "544007664");
            },
            child: const Text("Check for Update"),
          ),
        ),
      ),
    );
  }
}
