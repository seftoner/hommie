class Context {
  final String id;
  final String? user_id;
  final String? parent_id;

  Context({required this.id, this.user_id, this.parent_id});
}

sealed class HassEventBase {
  final String origin;
  final String timeFired;
  final Context context;

  HassEventBase(this.context, {required this.origin, required this.timeFired});
}

class HassEvent extends HassEventBase {
  final String eventType;
  final Map<String, dynamic> data;

  HassEvent(super.context, this.eventType, this.data,
      {required super.origin, required super.timeFired});
}
/*
sealed class WebSocketResponse {
  final int id;
  final String type;

  WebSocketResponse(this.id, this.type);
}

class WebSocketPongResponse extends WebSocketResponse {
  WebSocketPongResponse(int id) : super(id, "pong");
}

class WebSocketEventResponse extends WebSocketResponse {
  final HassEvent event;

  WebSocketEventResponse(int id, this.event) : super(id, "event");
}

class WebSocketResultResponse extends WebSocketResponse {
  final bool success;
  final dynamic result;

  WebSocketResultResponse(int id, this.success, this.result)
      : super(id, "result");
}

class WebSocketResultErrorResponse extends WebSocketResponse {
  final Map<String, String> error;

  WebSocketResultErrorResponse(int id, this.error) : super(id, "result");
}
 */