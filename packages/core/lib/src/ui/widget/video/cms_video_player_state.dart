import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:utopia_cms/src/util/foundation.dart';

class CmsVideoPlayerState {
  final VideoController videoController;
  final bool isInitialized;
  final Size naturalSize;
  final AnimationController animationController;
  final MutableValue<bool> isPlayingState;
  final FocusNode focusNode;

  const CmsVideoPlayerState({
    required this.videoController,
    required this.isInitialized,
    required this.naturalSize,
    required this.animationController,
    required this.isPlayingState,
    required this.focusNode,
  });
}

CmsVideoPlayerState useCmsVidePlayerState({required String url}) {
  final player = useMemoized(Player.new);
  final videoController = useMemoized(() => VideoController(player), [player]);

  useEffect(() {
    unawaited(player.open(Media(url), play: false));
    return null;
  }, [player, url]);

  // [VideoController] is released together with its [Player].
  useEffect(
    () =>
        () => unawaited(player.dispose()),
    [player],
  );

  final focusNode = useMemoized(FocusNode.new);
  final animationController = useAnimationController(duration: const Duration(milliseconds: 300));
  final isPlayingState = useState<bool>(false);

  // Drive rebuilds (and the "ready" signal) off the decoded video dimensions.
  final width = useMemoizedStreamData(() => player.stream.width, keys: [player], initialData: player.state.width) ?? 0;
  final height =
      useMemoizedStreamData(() => player.stream.height, keys: [player], initialData: player.state.height) ?? 0;
  final isInitialized = width > 0 && height > 0;

  final completed =
      useMemoizedStreamData(() => player.stream.completed, keys: [player], initialData: player.state.completed) ??
      false;

  useListenable(focusNode);

  useEffect(() {
    if (!focusNode.hasFocus) isPlayingState.value = false;
    return null;
  }, [focusNode.hasFocus]);

  useEffect(() {
    if (isPlayingState.value) {
      if (!focusNode.hasFocus) focusNode.requestFocus();
      unawaited(player.play());
      unawaited(animationController.forward());
    } else {
      unawaited(player.pause());
      unawaited(animationController.reverse());
    }
    return null;
  }, [isPlayingState.value]);

  useEffect(() {
    if (completed) {
      isPlayingState.value = false;
      unawaited(player.seek(Duration.zero));
    }
    return null;
  }, [completed]);

  return CmsVideoPlayerState(
    videoController: videoController,
    isInitialized: isInitialized,
    naturalSize: Size(width.toDouble(), height.toDouble()),
    animationController: animationController,
    isPlayingState: isPlayingState,
    focusNode: focusNode,
  );
}
