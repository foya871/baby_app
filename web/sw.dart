@JS()
library sw;

import 'dart:async';
import 'dart:js_interop';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:web/web.dart';

extension on ServiceWorkerGlobalScope {
  external set __interceptor(JSFunction f);
}

// https://developer.mozilla.org/en-US/docs/Web/API/ReadableStream/ReadableStream#underlyingsource
extension type _UnderlyingSource._(JSObject _) implements JSObject {
  external factory _UnderlyingSource({
    JSFunction? start,
    String? type,
  });
}

Future<void> _pump({
  required ReadableStream stream,
  required ReadableStreamDefaultController controller,
  required LocalServerHandleType handleType,
}) async {
  final reader = stream.getReader() as ReadableStreamDefaultReader;
  try {
    while (true) {
      final res = await reader.read().toDart;
      if (res.done) {
        controller.close();
        return;
      }
      if (res.value == null) continue;

      final chunk = (res.value as JSUint8Array).toDart;
      final decrypted = switch (handleType) {
        LocalServerHandleType.audio => LocalServerCross.decryptAudio(chunk),
        _ => chunk
      };
      controller.enqueue(decrypted.toJS);
    }
  } catch (e) {
    controller.error(e.jsify());
  } finally {
    reader.releaseLock();
  }
}

extension on ReadableStream {
  ReadableStream toDecryptStream(LocalServerHandleType handleType) {
    void start(ReadableStreamDefaultController controller) {
      _pump(stream: this, controller: controller, handleType: handleType);
    }

    return ReadableStream(
      _UnderlyingSource(
        type: 'bytes',
        start: start.toJS,
      ),
    );
  }
}

@JS('self')
external ServiceWorkerGlobalScope _self;

Future<Response> _buildResponse(
  FetchEvent event,
  Uri url,
  LocalServerHandleType handleType,
) async {
  final queryParameters = {...url.queryParameters}
    ..remove(LocalServerCross.specKeyHandleType);

  String newUrl = url.replace(queryParameters: queryParameters).toString();
  if (newUrl.endsWith('?')) {
    newUrl = newUrl.substring(0, newUrl.length - 1);
  }

  Response rawResp;
  try {
    final init = RequestInit(
      mode: 'cors',
      credentials: 'omit',
      keepalive: event.request.keepalive,
    );
    final resp = await _self.fetch(event.request, init).toDart;
    if (resp.type == 'opaque') {
      print('fetch cors fail resp opaque');
      return Response.error();
    }
    if (!resp.ok) {
      print('await resp not ok ${resp.status}');
      return Response(''.toJS, ResponseInit(status: resp.status));
    }
    rawResp = resp;
  } catch (e) {
    print('ex $e');
    return Response.error();
  }
  if (rawResp.body == null) {
    print('body null status:${rawResp.status} text:${rawResp.statusText}');
    return Response(
      rawResp.body,
      ResponseInit(
        status: rawResp.status,
        statusText: rawResp.statusText,
        headers: rawResp.headers,
      ),
    );
  }

  final decryptedStream = rawResp.body!.toDecryptStream(handleType);
  final headers = Headers(rawResp.headers);
  return Response(
    decryptedStream,
    ResponseInit(
      headers: headers,
      status: rawResp.status,
      statusText: rawResp.statusText,
    ),
  );
}

bool __interceptor(FetchEvent event) {
  if (event.request.method != 'GET') return false;

  final u = Uri.tryParse(event.request.url);
  if (u == null) return false;

  final handleTypeStr = u.queryParameters[LocalServerCross.specKeyHandleType];
  final handleType = LocalServerCross.getHandleType(handleTypeStr);
  if (handleType == null) {
    return false;
  }
  final promise = _buildResponse(event, u, handleType).toJS;
  event.respondWith(promise);
  return true;
}

void main() {
  _self.__interceptor = __interceptor.toJS;
}
