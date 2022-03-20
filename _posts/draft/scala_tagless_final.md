<pre>
<code>def tk[F[_],O](n: Long): Pipe[F,O,O] =
in => in.scanChunksOpt(n) { n =>
if (n <= 0) None
else Some(c => c.size match {
case m if m < n => (n - m, c)
case _ => (0, c.take(n.toInt))
})
}
def tk[F[_], O](n: Long): fs2.Pipe[F,O,O]</code>
</pre>

<p>why the parameter after function name is required.
</p>
<p>
</p>
<pre>
<code>scala> import fs2._
| 
| def tk(n: Long): Pipe[F,O,O] =
|   in => in.scanChunksOpt(n) { n =>
|     if (n <= 0) None
|     else Some(c => c.size match {
|       case m if m < n => (n - m, c)
|       case _ => (0, c.take(n.toInt))
|     })
|   }
| 
| 
def tk(n: Long): Pipe[F,O,O] =
^
On line 3: error: not found: type F
def tk(n: Long): Pipe[F,O,O] =
^
On line 3: error: not found: type O
def tk(n: Long): Pipe[F,O,O] =
^
On line 3: error: not found: type O
else Some(c => c.size match {
^
On line 6: error: missing parameter type</code>
</pre>
<p>
</p>
<p>based on Error above, type parameter after function name is for type parameter of function parameters.
</p>
<p>
</p>
<p>but, why the '_' in  F[_]. 
</p>
<p>
</p>
<pre>
<code>scala> :kind fs2.Pipe
fs2.Pipe's kind is X[F[A1],-A2,+A3]</code>
</pre>
<p>why '_' 
  <em>not in </em>
  <code>F[_]</code>
</p>
<p>
</p>
<p>when 
  <strong>lookup</strong> the scala doc 
</p>
<p>
</p>
<pre>
<code> type Pipe[F[_], -I, +O] = Stream[F, I] => Stream[F, O] // https://github.com/typelevel/fs2/blob/v0.10.4/core/shared/src/main/scala/fs2/fs2.scala</code>
</pre>
<p>
</p>
<p>check Stream
</p>
<pre>
<code>final class Stream[+F[_], +O] private (private val free: FreeC[Algebra[Nothing, Nothing, ?], Unit])</code>
</pre>
<p>
</p>
<p>
</p>
<p>
  <a href="https://kubuszok.com/2018/kinds-of-types-in-scala-part-2/" target="_blank" ref="nofollow noopener noreferrer">https://kubuszok.com/2018/kinds-of-types-in-scala-part-2/</a>
</p>
<p>
</p>
<p>推断： F[_] 在作为Generic Constraint 的时候，是定义F，使用的时候相当于是应用，即 
  <code>F[_]]</code>
</p>
<p>是定义，F 是应用。 
</p>
<p>
</p>
<p>比如， F
</p>
