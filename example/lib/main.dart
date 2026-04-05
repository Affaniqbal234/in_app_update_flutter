import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_update_flutter/in_app_update_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Platform.isAndroid
          ? const AndroidUpdateExample()
          : const IosUpdateExample(),
    );
  }
}

/// iOS example: shows the App Store product page overlay.
class IosUpdateExample extends StatelessWidget {
  const IosUpdateExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('In-App Update (iOS)')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              await InAppUpdateFlutter()
                  .showUpdateForIos(appStoreId: '544007664');
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e')),
                );
              }
            }
          },
          child: const Text('Show App Store Update'),
        ),
      ),
    );
  }
}

/// Android example: full Play Core in-app update flow.
class AndroidUpdateExample extends StatefulWidget {
  const AndroidUpdateExample({super.key});

  @override
  State<AndroidUpdateExample> createState() => _AndroidUpdateExampleState();
}

class _AndroidUpdateExampleState extends State<AndroidUpdateExample> {
  final _plugin = InAppUpdateFlutter();
  AppUpdateInfoAndroid? _updateInfo;
  String _status = 'Idle';

  Future<void> _checkForUpdate() async {
    setState(() => _status = 'Checking for update...');
    try {
      final info = await _plugin.checkUpdateAndroid();
      setState(() {
        _updateInfo = info;
        _status = 'Update availability: ${info.updateAvailability.name}';
      });
    } catch (e) {
      setState(() => _status = 'Error: $e');
    }
  }

  Future<void> _startImmediateUpdate() async {
    setState(() => _status = 'Starting immediate update...');
    try {
      final result = await _plugin.startImmediateUpdateAndroid();
      setState(() => _status = 'Immediate update result: ${result.name}');
    } catch (e) {
      setState(() => _status = 'Error: $e');
    }
  }

  Future<void> _startFlexibleUpdate() async {
    setState(() => _status = 'Starting flexible update...');
    try {
      final result = await _plugin.startFlexibleUpdateAndroid();
      setState(() => _status = 'Flexible update result: ${result.name}');
    } catch (e) {
      setState(() => _status = 'Error: $e');
    }
  }

  Future<void> _completeUpdate() async {
    setState(() => _status = 'Completing update...');
    try {
      await _plugin.completeUpdateAndroid();
      setState(() => _status = 'Update complete — app will restart');
    } catch (e) {
      setState(() => _status = 'Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUpdateAvailable = _updateInfo?.updateAvailability ==
        UpdateAvailabilityAndroid.updateAvailable;

    return Scaffold(
      appBar: AppBar(title: const Text('In-App Update (Android)')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(_status, style: Theme.of(context).textTheme.bodyLarge),
            if (_updateInfo != null) ...[
              const SizedBox(height: 8),
              Text('Version code: ${_updateInfo!.availableVersionCode ?? "N/A"}'),
              Text('Priority: ${_updateInfo!.updatePriority}'),
              Text('Staleness: ${_updateInfo!.clientVersionStalenessDays ?? "N/A"} days'),
              Text('Immediate allowed: ${_updateInfo!.isImmediateUpdateAllowed}'),
              Text('Flexible allowed: ${_updateInfo!.isFlexibleUpdateAllowed}'),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _checkForUpdate,
              child: const Text('Check for Update'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: isUpdateAvailable ? _startImmediateUpdate : null,
              child: const Text('Start Immediate Update'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: isUpdateAvailable ? _startFlexibleUpdate : null,
              child: const Text('Start Flexible Update'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _completeUpdate,
              child: const Text('Complete Update'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Flexible Update Progress:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            StreamBuilder<InstallStateAndroid>(
              stream: _plugin.installStateStreamAndroid,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text('No active download');
                }
                final state = snapshot.data!;
                final progress = state.totalBytesToDownload > 0
                    ? state.bytesDownloaded / state.totalBytesToDownload
                    : 0.0;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Status: ${state.status.name}'),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(value: progress),
                    const SizedBox(height: 4),
                    Text(
                      '${state.bytesDownloaded} / ${state.totalBytesToDownload} bytes',
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
