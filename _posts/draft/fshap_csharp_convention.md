<p>F#
</p>
<p>
</p>
<pre>
<code> let configurePolicy (corsBuilder: CorsPolicyBuilder) =
corsBuilder
.AllowAnyOrigin()
.AllowAnyHeader()
.AllowAnyMethod()
.AllowCredentials()
|> ignore
services.AddCors(fun options -> options.AddPolicy ("anyCors", configurePolicy))</code>
</pre>
<p>
</p>
<p>C# 
</p>
<pre>
<code> services.AddCors(options =>
{
options.AddPolicy(name: MyAllowSpecificOrigins,
builder =>
{
builder.WithOrigins("http://example.com",
"http://www.contoso.com");
});
});</code>
</pre>
<p>
</p>
<p>AddPolicy take two parameters in C#, in F#,  AddPolicy take one parameter, which is a tuple of the two parameter in C# 
</p>
