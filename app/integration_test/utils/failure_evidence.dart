import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

const e2eCaptureKey = ValueKey('e2e.capture');

/// Capture only the Flutter surface. Native credential sheets stay out of this image.
/// The host retains images privately for visual review before sharing.
Future<void> captureFailureImage(String runId) async {
  final elements = WidgetsBinding.instance.rootElement;
  if (elements == null) {
    return;
  }
  RenderRepaintBoundary? boundary;
  void visit(Element element) {
    if (element.widget.key == e2eCaptureKey) {
      boundary = element.renderObject as RenderRepaintBoundary?;
    }
    element.visitChildren(visit);
  }

  visit(elements);
  if (boundary == null || boundary!.debugNeedsPaint) {
    return;
  }
  final image = await boundary!.toImage(pixelRatio: 1);
  try {
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    if (bytes == null) {
      return;
    }
    final support = await getApplicationSupportDirectory();
    await File('${support.path}/hommie_e2e_failure_$runId.png')
        .writeAsBytes(bytes.buffer.asUint8List(), flush: true);
  } finally {
    image.dispose();
  }
}
