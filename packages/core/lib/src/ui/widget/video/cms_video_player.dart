import 'package:flutter/material.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:utopia_cms/src/ui/widget/video/cms_video_player_state.dart';
import 'package:utopia_cms/src/util/foundation.dart';
import 'package:utopia_cms_ui/utopia_cms_ui.dart';

class CmsVideoPlayer extends HookWidget {
  final String url;

  /// Wraps the rendered video. Receives the video's natural [Size] and the
  /// player widget already sized to that natural size (handy for `FittedBox`
  /// based cropping). When null, the video is shown at its own aspect ratio.
  final Widget Function(Size naturalSize, Widget player)? playerBuilder;
  final bool previewOnly;

  const CmsVideoPlayer({super.key, required this.url, this.playerBuilder, this.previewOnly = false});

  @override
  Widget build(BuildContext context) {
    final state = useCmsVideoPlayerState(url: url);

    return IgnorePointer(
      ignoring: previewOnly,
      child: Focus(
        focusNode: state.focusNode,
        child: state.isInitialized ? _buildVideo(state: state) : const CmsLoader(color: Colors.white),
      ),
    );
  }

  Widget _buildVideo({required CmsVideoPlayerState state}) {
    final player = Video(controller: state.videoController, controls: null);
    return Stack(
      alignment: Alignment.center,
      children: [
        if (playerBuilder != null)
          playerBuilder!(state.naturalSize, SizedBox.fromSize(size: state.naturalSize, child: player))
        else
          AspectRatio(aspectRatio: state.naturalSize.aspectRatio, child: player),
        if (!previewOnly) _buildPlayButton(state),
      ],
    );
  }

  Widget _buildPlayButton(CmsVideoPlayerState state) {
    return Center(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => state.isPlayingState.value = !state.isPlayingState.value,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 1.0,
                top: 2.0,
                child: AnimatedIcon(
                  icon: AnimatedIcons.play_pause,
                  progress: state.animationController,
                  color: Colors.black12,
                  size: 30,
                ),
              ),
              AnimatedIcon(
                icon: AnimatedIcons.play_pause,
                progress: state.animationController,
                color: Colors.white,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
