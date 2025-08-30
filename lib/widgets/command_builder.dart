import 'package:flutter/material.dart';
import '../states/command.dart';

class CommandBuilder<TSuccess, TFailure> extends StatelessWidget {
  final CommandBase<TSuccess, TFailure> command;
  final Widget Function(
    BuildContext context,
    CommandState<TSuccess, TFailure> state,
  )
  builder;

  const CommandBuilder({
    super.key,
    required this.command,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: command,
      builder: (_, __) {
        final state = CommandState.fromCommand(command);
        return builder(context, state);
      },
    );
  }
}
