---
layout: post
title:  gRPC-Web Auth interceptor
date:   2024-06-11 08:15
categories: tech 
---

## create ClientReadableStream that does nothing

```js
/**
 * A ClientReadableStream wrapper.
 *
 * @template RESPONSE
 * @implements {ClientReadableStream}
 * @constructor
 * @param {!ClientReadableStream<RESPONSE>} stream
 */
class InterceptedStream {
  constructor(stream) {
    this.stream = stream;
  }

  /** @override */
  on(eventType, callback) {
    this.stream.on(eventType, callback);
    return this;
  }

  /** @override */
  cancel() {
    this.stream.cancel();
    return this;
  }
}
```

## create AuthMetadataStreamInterceptor do nothing using the InterceptedStream

```js
/**
 * @constructor
 * @implements {StreamInterceptor}
 */
class AuthMetadataStreamInterceptor {
  constructor() { }
  /** @override */
  intercept(request, invoker) {
    return new InterceptedStream(invoker(request));
  }
}
```

## Add custom logic

It is not our goal to create the interceptedStream and interceptor that does nothing.
However, the plain interceptor demostrated the interceptor  request/response logic.
now it is obvious that if we want to add custom metdata `Authorization: Bear XXX` to request, we need change the request before `invoker(request)`.


```js
  intercept(request, invoker) {
    let metadata = request.getMetadata();
    let authorization = "Bearer" + "XXX"
    metadata['Authorization'] = authorization;
    // not sure why withMetadata does not work
    //request.withMetadata('Authorization', headers.Authorization);
    return new InterceptedStream(invoker(request));
  }
```


## add the intercept to grpc client

```js

let ops = { 'streamInterceptors': [new AuthMetadataStreamInterceptor()] };

const grpc = new YourGrpcWebClient(
  hostname(), null, ops
);
```

