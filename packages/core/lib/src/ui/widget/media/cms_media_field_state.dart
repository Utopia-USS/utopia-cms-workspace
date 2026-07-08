import 'dart:async';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';
import 'package:utopia_cms/src/delegate/media/cms_media_delegate.dart';
import 'package:utopia_cms/src/ui/item_management/state/cms_management_state.dart';
import 'package:utopia_cms/src/ui/media_preview/cms_media_preview_page.dart';
import 'package:utopia_cms/src/ui/media_preview/cms_media_type.dart';
import 'package:utopia_cms/src/util/foundation.dart';
import 'package:utopia_cms_ui/utopia_cms_ui.dart';

/// Drag-and-drop file formats and their canonical MIME type, covering the MIME
/// types declared by [CmsMediaType]. super_clipboard does not expose a format's
/// MIME at runtime, so the mapping is explicit.
const _formatMimes = <(FileFormat, String)>[
  (Formats.jpeg, 'image/jpeg'),
  (Formats.png, 'image/png'),
  (Formats.gif, 'image/gif'),
  (Formats.webp, 'image/webp'),
  (Formats.mp4, 'video/mp4'),
  (Formats.webm, 'video/webm'),
  (Formats.mov, 'video/quicktime'),
  (Formats.m4v, 'video/x-m4v'),
  (Formats.pdf, 'application/pdf'),
  (Formats.doc, 'application/msword'),
  (Formats.docx, 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'),
  (Formats.xls, 'application/vnd.ms-excel'),
  (Formats.xlsx, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'),
  (Formats.ppt, 'application/vnd.ms-powerpoint'),
  (Formats.pptx, 'application/vnd.openxmlformats-officedocument.presentationml.presentation'),
  (Formats.csv, 'text/csv'),
  (Formats.epub, 'application/epub+zip'),
  (Formats.plainTextFile, 'text/plain'),
];

/// Maps MIME types to the file extensions `file_selector` needs (Windows
/// filters by extension and throws without one).
const _mimeToExtension = <String, String>{
  'video/mp4': 'mp4',
  'video/webm': 'webm',
  'video/quicktime': 'mov',
  'video/x-m4v': 'm4v',
  'image/jpeg': 'jpg',
  'image/png': 'png',
  'image/gif': 'gif',
  'image/webp': 'webp',
  'application/msword': 'doc',
  'application/vnd.ms-excel': 'xls',
  'application/vnd.openxmlformats-officedocument.wordprocessingml.document': 'docx',
  'application/pdf': 'pdf',
  'text/csv': 'csv',
  'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet': 'xlsx',
  'application/epub+zip': 'epub',
  'text/plain': 'txt',
  'application/vnd.ms-powerpoint': 'ppt',
  'application/vnd.openxmlformats-officedocument.presentationml.presentation': 'pptx',
};

/// Accepted (format, mime) pairs for the given supported [mimes].
/// Empty [mimes] = accept every known media format.
List<(FileFormat, String)> _acceptedFormats(List<String> mimes) =>
    mimes.isEmpty ? _formatMimes : _formatMimes.where((entry) => mimes.contains(entry.$2)).toList();

List<String> _extensionsFor(List<String> mimes) =>
    mimes.map((mime) => _mimeToExtension[mime]).whereType<String>().toList();

class CmsMediaFieldState {
  final CmsMediaDelegate delegate;

  /// if XFile it's a new one
  final IList<dynamic> files;

  /// Optional cap on how many files may be present at once. `null` = unlimited.
  /// When `files.length >= maxFiles`, the add button is hidden and drop/pick
  /// reject extra files.
  final int? maxFiles;

  final MutableValue<bool> isHighlighted;

  /// Formats the drop region advertises as droppable (drives the OS cursor).
  final List<DataFormat> dropFormats;

  final void Function() setHighlightedTrue;
  final void Function() setHighlightedFalse;
  final DropOperation Function(DropOverEvent) onDropOver;
  final Future<void> Function(PerformDropEvent) onPerformDrop;
  final void Function(int index, dynamic value) onUploaded;
  final Future<void> Function() onSelectFilePressed;

  final void Function(int index) onNavigateToPreview;
  final void Function(int index) onRemove;
  final void Function(int oldIndex, int newIndex) onReorder;

  const CmsMediaFieldState({
    required this.isHighlighted,
    required this.delegate,
    required this.dropFormats,
    required this.onDropOver,
    required this.onPerformDrop,
    required this.onRemove,
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

  final supportedMimes = supportedMedia.getMimes;
  final accepted = useMemoized(() => _acceptedFormats(supportedMimes), [supportedMimes.join(',')]);
  final dropFormats = accepted.map<DataFormat>((entry) => entry.$1).toList();

  bool isAtMax() {
    final max = maxFiles;
    return max != null && filesState.value.length >= max;
  }

  void addXFiles(Iterable<XFile> picked) {
    final max = maxFiles;
    final remaining = max == null ? picked.toList() : picked.take(max - filesState.value.length).toList();
    if (remaining.isNotEmpty) filesState.value = filesState.value.addAll(remaining);
  }

  void showUnsupported() {
    if (context.mounted) {
      unawaited(
        CmsConfirmDialog.show(
          context,
          title: "Incorrect file",
          subtitle: "Provided file has unsupported format",
          hasConfirm: false,
        ),
      );
    }
  }

  DropOperation onDropOver(DropOverEvent event) {
    if (isAtMax()) return DropOperation.none;
    final hasSupported = event.session.items.any((item) => accepted.any((entry) => item.canProvide(entry.$1)));
    if (!hasSupported) return DropOperation.none;
    return event.session.allowedOperations.contains(DropOperation.copy) ? DropOperation.copy : DropOperation.none;
  }

  Future<void> onPerformDrop(PerformDropEvent event) async {
    isHighlightedState.value = false;
    if (isAtMax()) return;
    final reads = <Future<XFile?>>[];
    var rejected = false;
    for (final item in event.session.items) {
      final reader = item.dataReader;
      if (reader == null) continue;
      (FileFormat, String)? match;
      for (final entry in accepted) {
        if (reader.canProvide(entry.$1)) {
          match = entry;
          break;
        }
      }
      if (match == null) {
        rejected = true;
        continue;
      }
      final mime = match.$2;
      final completer = Completer<XFile?>();
      final progress = reader.getFile(match.$1, (file) async {
        try {
          final bytes = await file.readAll();
          final name = file.fileName ?? await reader.getSuggestedName() ?? 'file';
          completer.complete(XFile.fromData(bytes, name: name, length: bytes.length, mimeType: mime));
        } catch (_) {
          completer.complete(null);
        }
      }, onError: (_) => completer.complete(null));
      if (progress == null) completer.complete(null);
      reads.add(completer.future);
    }
    if (rejected) showUnsupported();
    final xFiles = (await Future.wait(reads)).whereType<XFile>();
    addXFiles(xFiles);
  }

  Future<void> selectFiles() async {
    if (isAtMax()) return;
    final group = XTypeGroup(
      label: 'Media',
      mimeTypes: supportedMimes.isEmpty ? null : supportedMimes,
      extensions: supportedMimes.isEmpty ? null : _extensionsFor(supportedMimes),
    );
    final picked = await openFiles(acceptedTypeGroups: [group]);
    addXFiles(picked);
  }

  useEffect(() {
    final values = filesState.value;
    onChanged(values.isEmpty ? null : uploadedItems.unlock);
    return null;
  }, [filesState.value]);

  useEffect(() {
    baseState.addOnSavedCallback((value) async {
      await Future.wait(deletedFilesState.value.map((e) async => delegate.delete(e)));
    });
    return null;
  }, []);

  Future<void> navigateToPreview(int index) async {
    await navigator.push<bool?>(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.black87,
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 400),
        // Like the sibling dialog helpers, re-attach the ambient theme: the
        // route roots at the app Navigator, outside the CmsTheme subtree.
        pageBuilder: (_, animation, _) => CmsTheme.captured(
          context,
          child: CmsMediaPreviewPage(
            args: CmsMediaPreviewPageArgs(
              items: uploadedItems,
              initialIndex: index,
              urlBuilder: urlBuilder,
              mediaTypeBuilder: mediaTypeBuilder,
            ),
            animation: animation,
          ),
        ),
      ),
    );
  }

  return CmsMediaFieldState(
    isHighlighted: isHighlightedState,
    setHighlightedTrue: () => isHighlightedState.value = true,
    setHighlightedFalse: () => isHighlightedState.value = false,
    dropFormats: dropFormats,
    onDropOver: onDropOver,
    onPerformDrop: onPerformDrop,
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
