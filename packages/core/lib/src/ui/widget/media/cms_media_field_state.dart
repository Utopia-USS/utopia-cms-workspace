import 'dart:async';

import 'package:cross_file/cross_file.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:provider/provider.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_cms/src/delegate/media/cms_media_delegate.dart';
import 'package:utopia_cms/src/ui/item_management/state/cms_management_state.dart';
import 'package:utopia_cms/src/ui/media_preview/cms_media_preview_page.dart';
import 'package:utopia_cms/src/ui/media_preview/cms_media_type.dart';
import 'package:utopia_cms/src/ui/widget/dialog/cms_dialog.dart';

class CmsMediaFieldState {
  final CmsMediaDelegate delegate;

  /// if XFile it's a new one
  final IList<dynamic> files;

  /// Optional cap on how many files may be present at once. `null` = unlimited.
  /// When `files.length >= maxFiles`, the add button is hidden and drop/pick
  /// reject extra files.
  final int? maxFiles;

  final MutableValue<bool> isHighlighted;
  final void Function() setHighlightedTrue;
  final void Function() setHighlightedFalse;
  final void Function(DropzoneViewController) onCreated;
  final Future<void> Function(DropzoneFileInterface)
  onDropFile; //in flutter_dropzone docs this variable has to be dynamic
  final void Function(int index, dynamic value) onUploaded;
  final Future<void> Function() onSelectFilePressed;

  final void Function(int index) onNavigateToPreview;
  final void Function(int index) onRemove;
  final void Function(int oldIndex, int newIndex) onReorder;

  const CmsMediaFieldState({
    required this.isHighlighted,
    required this.delegate,
    required this.onDropFile,
    required this.onRemove,
    required this.onCreated,
    required this.onSelectFilePressed,
    required this.setHighlightedFalse,
    required this.setHighlightedTrue,
    required this.onUploaded,
    required this.onNavigateToPreview,
    required this.onReorder,
    required this.files,
    this.maxFiles,
  });

  bool get isAtMaxFiles => maxFiles != null && files.length >= maxFiles!;
}

CmsMediaFieldState useCmsMediaFieldState({
  required CmsMediaDelegate delegate,
  required Iterable<dynamic>? initialValues,
  required List<CmsMediaType> supportedMedia,
  required void Function(Iterable<dynamic>? values) onChanged,
  required String Function(dynamic object)? urlBuilder,
  required CmsMediaType Function(dynamic object) mediaTypeBuilder,
  required NavigatorState navigator,
  int? maxFiles,
}) {
  final controller = useState<DropzoneViewController?>(null);
  final isHighlightedState = useState<bool>(false);

  final context = useBuildContext();
  // `CmsManagementOverlay` provides the base state via Flutter's
  // [Provider.value], not via the utopia_hooks `ProviderWidget` that
  // `useProvided` looks up. Read it through the Flutter context so the
  // lookups match.
  final baseState = Provider.of<CmsManagementBaseState>(context, listen: false);
  final filesState = useState<IList<dynamic>>(initialValues?.toIList() ?? IList());
  final deletedFilesState = useState<IList<dynamic>>(IList());
  final uploadedItems = filesState.value.where((e) => e is! XFile).toIList();

  Future<bool> checkMIME(DropzoneFileInterface event, DropzoneViewController controller) async {
    final mime = await controller.getFileMIME(event);

    final isCorrect = supportedMedia.getMimes.contains(mime);
    if (context.mounted &&!isCorrect) {
      unawaited(
        CmsDialog.show(
          context,
          title: "Incorrect file",
          subtitle: "Provided file has unsupported format",
          hasProceed: false,
        ),
      );
    }
    return isCorrect;
  }

  Future<XFile> setUpXFile(DropzoneFileInterface file) async {
    final data = await controller.value!.getFileData(file);
    final mime = await controller.value!.getFileMIME(file);
    final size = await controller.value!.getFileSize(file);
    final name = await controller.value!.getFilename(file);
    return XFile.fromData(data, name: name, length: size, mimeType: mime);
  }

  bool isAtMax() {
    final max = maxFiles;
    return max != null && filesState.value.length >= max;
  }

  Future<void> dropFile(DropzoneFileInterface file) async {
    if (controller.value != null) {
      if (isAtMax()) {
        isHighlightedState.value = false;
        return;
      }
      final isImage = await checkMIME(file, controller.value!);
      isHighlightedState.value = false;
      if (isImage) {
        final xFile = await setUpXFile(file);
        filesState.value = filesState.value.add(xFile);
      } else {}
    }
  }

  Future<void> selectFiles() async {
    if (controller.value != null) {
      if (isAtMax()) return;
      final files = await controller.value!.pickFiles(mime: supportedMedia.getMimes);
      final remaining = maxFiles == null ? files : files.take(maxFiles - filesState.value.length);
      final xFiles = await Future.wait(remaining.map((e) async => setUpXFile(e)));
      filesState.value = filesState.value.addAll(xFiles);
    }
  }

  useEffect(() {
    final values = filesState.value;
    onChanged(values.isEmpty ? null : uploadedItems.unlock);
  }, [filesState.value]);

  useEffect(() {
    baseState.addOnSavedCallback((value) async {
      await Future.wait(deletedFilesState.value.map((e) async => delegate.delete(e)));
    });
  }, []);

  Future<void> navigateToPreview(int index) async {
    await navigator.push<bool?>(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.black87,
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, animation, _) => CmsMediaPreviewPage(
          args: CmsMediaPreviewPageArgs(
            items: uploadedItems,
            initialIndex: index,
            urlBuilder: urlBuilder,
            mediaTypeBuilder: mediaTypeBuilder,
          ),
          animation: animation,
        ),
      ),
    );
  }

  return CmsMediaFieldState(
    isHighlighted: isHighlightedState,
    setHighlightedTrue: () => isHighlightedState.value = true,
    setHighlightedFalse: () => isHighlightedState.value = false,
    onCreated: (value) => controller.value = value,
    onDropFile: dropFile,
    delegate: delegate,
    onSelectFilePressed: selectFiles,
    onNavigateToPreview: navigateToPreview,
    files: filesState.value,
    maxFiles: maxFiles,
    onUploaded: (index, value) {
      filesState.value = filesState.value.removeAt(index);
      filesState.value = filesState.value.insert(index, value);
    },
    onReorder: (oldIndex, newIndex) {
      final item = filesState.value[oldIndex];
      filesState.value = filesState.value.removeAt(oldIndex);
      filesState.value = filesState.value.insert(newIndex, item);
    },
    onRemove: (index) {
      final value = filesState.value[index];
      filesState.value = filesState.value.removeAt(index);
      deletedFilesState.value = deletedFilesState.value.add(value);
    },
  );
}
