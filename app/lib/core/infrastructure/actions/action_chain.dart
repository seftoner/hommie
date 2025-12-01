import 'package:hommie/core/infrastructure/actions/haction.dart';
import 'package:hommie/core/infrastructure/actions/haction_execution_context.dart';

class ActionChain {
  final List<HAction> actions;
  final ActionExecutionContext context;
  final Map<Type, void Function(Object error)> errorHandlers;
  final void Function(ActionExecutionContext context)? onSuccess;
  final void Function(Object error)? defaultErrorHandler;

  ActionChain({
    required this.actions,
    required this.context,
    required this.errorHandlers,
    this.onSuccess,
    this.defaultErrorHandler,
  });

  static ActionChainBuilder builder() => ActionChainBuilder();
}

class ActionChainBuilder {
  final List<HAction> _actions = [];
  final Map<String, dynamic> _context = {};
  final Map<Type, void Function(Object error)> _errorHandlers = {};
  void Function(ActionExecutionContext context)? _onSuccess;
  void Function(Object error)? _defaultErrorHandler;

  ActionChainBuilder addAction(HAction action) {
    _actions.add(action);
    return this;
  }

  ActionChainBuilder withContext(String key, dynamic value) {
    _context[key] = value;
    return this;
  }

  ActionChainBuilder onActionError<T extends HAction<dynamic, TError>, TError>(
    void Function(TError error) handler,
  ) {
    _errorHandlers[T] = (error) => handler(error as TError);
    return this;
  }

  ActionChainBuilder onAnyError(void Function(Object error) handler) {
    _defaultErrorHandler = handler;
    return this;
  }

  ActionChainBuilder onSuccess(
    void Function(ActionExecutionContext context) handler,
  ) {
    _onSuccess = handler;
    return this;
  }

  ActionChain build() => ActionChain(
    actions: _actions,
    context: ActionExecutionContext(_context),
    errorHandlers: _errorHandlers,
    onSuccess: _onSuccess,
    defaultErrorHandler: _defaultErrorHandler,
  );
}
