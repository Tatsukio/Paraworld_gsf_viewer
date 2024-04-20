import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paraworld_gsf_viewer/classes/gsf/gsf.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:paraworld_gsf_viewer/providers/texture.dart';

/// Provider that holds the path of a specific gsf file from anywhere in the system
final overridingGsfPathStateProvider =
    StateProvider<PlatformFile?>((ref) => null);

/// Provider that holds the path of a selected gsf file in the Paraworld folder
final gsfSelectedFileInPwFolderProvider = StateProvider<String?>((ref) => null);

/// Provider that reads a gsf model file and returns the GSF object
final gsfProvider = FutureProvider<GSF?>(
  (ref) async {
    final overridingGsf = ref.watch(overridingGsfPathStateProvider);
    final selectedGsf = ref.watch(gsfSelectedFileInPwFolderProvider);

    if (overridingGsf == null && selectedGsf == null) {
      final testFile = await rootBundle.load('assets/test_objects.gsf');
      return GSF.fromBytes(testFile.buffer.asUint8List());
    }
    if (overridingGsf != null) {
      if (overridingGsf.bytes != null) {
        return GSF.fromBytes(overridingGsf.bytes!);
      }
      if (overridingGsf.path != null) {
        final data = File(overridingGsf.path!);
        final bytes = await data.readAsBytes();
        return GSF.fromBytes(bytes);
      }
    }
    if (selectedGsf != null && selectedGsf.isNotEmpty) {
      final data = File(selectedGsf);
      final bytes = await data.readAsBytes();
      return GSF.fromBytes(bytes);
    }

    return null;
  },
);

final gsfFilesListProvider = FutureProvider<List<String>>(
  (ref) async {
    final pwFolderPath = ref.watch(pwFolderPathStateProvider);
    if (pwFolderPath == null) {
      return [];
    }
    final directory = Directory('$pwFolderPath/Data/Base/GSF');
    final gsfs = await directory
        .list()
        .where((file) => file.path.endsWith('.gsf'))
        .map((gsf) => gsf.path)
        .toList();
    return gsfs..sort();
  },
);
