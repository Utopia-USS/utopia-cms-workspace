import 'package:flutter/widgets.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

import '../app_images.dart';

/// One-shot startup state that decodes the menu/logo art into Flutter's image
/// cache before the shell paints, so the sidebar logo doesn't pop in on load.
/// Readiness IS the computed value - `isInitialized` flips once every asset in
/// [AppImages.precached] is decoded (see the utopia_hooks "one-shot setup as a
/// value-less computed state" idiom).
class ImagePrecacheState extends HasInitialized {
  const ImagePrecacheState({required super.isInitialized});
}

/// Global state hook. Registered in main.dart's `_providers` under
/// [ImagePrecacheState] and read by the shell's precache gate.
ImagePrecacheState useImagePrecacheState() {
  final context = useBuildContext();

  final state = useAutoComputedState<void>(
    () async => Future.wait([for (final image in AppImages.precached) precacheImage(AssetImage(image), context)]),
    isRetryable: true,
  );

  return ImagePrecacheState(isInitialized: state.isInitialized);
}
