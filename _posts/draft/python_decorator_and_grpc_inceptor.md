<pre>
<code># https://medium.com/pythonhive/python-decorator-to-measure-the-execution-time-of-methods-fa04cb6bb36d
def timeit(method):
def timed(*args, **kw):
ts = time.time()
result = method(*args, **kw)
te = time.time()
if 'log_time' in kw:
name = kw.get('log_name', method.__name__.upper())
kw['log_time'][name] = int((te - ts) * 1000)
else:
print '%r  %2.2f ms' % \
(method.__name__, (te - ts) * 1000)
return result
return timed</code>
</pre>

<p>
</p>
<p>If grpc has exception, print the 
  <strong>in and out</strong>.
</p>
<p>
</p>
<p>if slow grpc, send the parameter
</p>
<p>
</p>
<p>
</p>
<pre>
<code>"""Implementation of gRPC Python interceptors."""
import collections
import sys
import grpc
class _ServicePipeline(object):
def __init__(self, interceptors):
self.interceptors = tuple(interceptors)
def _continuation(self, thunk, index):
return lambda context: self._intercept_at(thunk, index, context)
def _intercept_at(self, thunk, index, context):
if index < len(self.interceptors):
interceptor = self.interceptors[index]
thunk = self._continuation(thunk, index + 1)
return interceptor.intercept_service(thunk, context)
else:
return thunk(context)
def execute(self, thunk, context):
return self._intercept_at(thunk, 0, context)
def service_pipeline(interceptors):
return _ServicePipeline(interceptors) if interceptors else None
class _ClientCallDetails(
collections.namedtuple('_ClientCallDetails',
('method', 'timeout', 'metadata', 'credentials',
'wait_for_ready', 'compression')),
grpc.ClientCallDetails):
pass</code>
</pre>
<pre>
<code>  def _wrap_rpc_behavior(self, handler, fn):
"""Returns a new rpc handler that wraps the given function"""
if handler is None:
return None
if handler.request_streaming and handler.response_streaming:
behavior_fn = handler.stream_stream
handler_factory = grpc.stream_stream_rpc_method_handler
elif handler.request_streaming and not handler.response_streaming:
behavior_fn = handler.stream_unary
handler_factory = grpc.stream_unary_rpc_method_handler
elif not handler.request_streaming and handler.response_streaming:
behavior_fn = handler.unary_stream
handler_factory = grpc.unary_stream_rpc_method_handler
else:
behavior_fn = handler.unary_unary
handler_factory = grpc.unary_unary_rpc_method_handler
return handler_factory(
fn(behavior_fn, handler.request_streaming, handler.response_streaming),
request_deserializer=handler.request_deserializer,
response_serializer=handler.response_serializer)</code>
</pre>
<p>
</p>
