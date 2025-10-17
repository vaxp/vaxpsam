import 'dart:async';

import 'package:flutter/material.dart';
import '../../domain/command_output_line.dart';
import 'console_modal.dart';

void showConsoleStream(BuildContext context, Stream<CommandOutputLine> stream) {
  // Forward the incoming stream into a controller so we can add an initial line
  final controller = StreamController<CommandOutputLine>();
  // Add a starting line to give immediate feedback
  controller.add(
    CommandOutputLine(
      timestamp: DateTime.now(),
      text: 'Starting...',
      isError: false,
    ),
  );

  // Listen to the source stream and forward events to the controller
  final sub = stream.listen(
    (line) {
      if (!controller.isClosed) controller.add(line);
    },
    onError: (err, st) {
      if (!controller.isClosed)
        controller.add(
          CommandOutputLine(
            timestamp: DateTime.now(),
            text: 'Error: $err',
            isError: true,
          ),
        );
    },
    onDone: () async {
      if (!controller.isClosed) {
        controller.add(
          CommandOutputLine(
            timestamp: DateTime.now(),
            text: '[Process finished]',
            isError: false,
          ),
        );
        await controller.close();
      }
    },
    cancelOnError: false,
  );

  // Show the modal and pass the controller's stream. When the modal closes, clean up.
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
    ),
    builder:
        (ctx) => SizedBox(
          height: MediaQuery.of(ctx).size.height * 0.6,
          child: ConsoleModal(stream: controller.stream),
        ),
  ).whenComplete(() async {
    // Modal closed: cancel subscription and close controller if open.
    try {
      await sub.cancel();
    } catch (_) {}
    if (!controller.isClosed) await controller.close();
  });
}
