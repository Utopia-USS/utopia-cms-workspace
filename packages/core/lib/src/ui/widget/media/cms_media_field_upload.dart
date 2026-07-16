import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_cms/src/util/context_extensions.dart';
import 'package:utopia_cms/utopia_cms.dart';

class CmsMediaFieldUpload extends HookWidget {
  final CmsMediaFieldState state;
  final CmsMediaDelegate delegate;
  final double size;
  final XFile file;
  final int index;
  final dynamic Function(CmsMediaUploadRes res, XFile file)? valueBuilder;

  const CmsMediaFieldUpload({
    super.key,
    required this.size,
    required this.state,
    required this.delegate,
    required this.valueBuilder,
    required this.file,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final upload = useAutoComputedState(() async {
      final result = await delegate.upload(file);
      final enhancedResult = valueBuilder?.call(result, file);
      state.onUploaded(index, enhancedResult ?? result.downloadUrl);
    }, keys: []);
    // A failed upload must not spin forever - show an error tile the user can
    // tap to dismiss (the real cause is logged by the delegate).
    final failed = upload.value is ComputedStateValueFailed;
    return CmsMediaFieldItemWrapper(
      key: Key(file.path),
      size: size,
      child: failed
          ? Tooltip(
              message: 'Upload failed - tap to remove',
              child: InkWell(
                onTap: () => state.onRemove(index),
                child: ColoredBox(
                  color: Colors.red.shade700,
                  child: const Icon(Icons.error_outline, color: Colors.white, size: 36),
                ),
              ),
            )
          : ColoredBox(
              color: context.colors.primary,
              child: const CmsLoader(color: Colors.white),
            ),
    );
  }
}
