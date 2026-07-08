import 'package:flutter/material.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';
import 'package:utopia_cms/src/ui/widget/media/cms_media_field_item_wrapper.dart';
import 'package:utopia_cms/src/ui/widget/media/cms_media_field_state.dart';
import 'package:utopia_cms_ui/utopia_cms_ui.dart';

class CmsMediaFieldAddButton extends StatelessWidget {
  final CmsMediaFieldState state;
  final double size;

  const CmsMediaFieldAddButton({super.key, required this.state, required this.size});

  @override
  Widget build(BuildContext context) {
    return DropRegion(
      formats: state.dropFormats,
      hitTestBehavior: HitTestBehavior.opaque,
      onDropOver: state.onDropOver,
      onDropEnter: (_) => state.setHighlightedTrue(),
      onDropLeave: (_) => state.setHighlightedFalse(),
      onPerformDrop: state.onPerformDrop,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: state.onSelectFilePressed,
          behavior: HitTestBehavior.opaque,
          child: CmsMediaFieldItemWrapper(
            size: size,
            hasShadow: false,
            color: state.isHighlighted.value ? context.colors.primary : context.colors.field,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.upload, color: context.textStyles.text.color, size: 36),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: size / 3 * 2,
                    child: Text(
                      "Drag & drop\nor tap to select",
                      style: context.textStyles.caption,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
