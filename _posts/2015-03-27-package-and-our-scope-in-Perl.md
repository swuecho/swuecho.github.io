---
layout: post
title:  package and our scope in Perl
date:   2015-03-27 11:56 
categories: tech 
---

When I come across *our*, I find I not quite understand it, so <code> perldoc -f our</code>

{% highlight perl %}


package Foo;
    our $bar;      # declares $Foo::bar for rest of lexical scope
    $bar = 20;
package Bar;
    print $bar;    # prints 20, as it refers to $Foo::bar


{% endhighlight %}

I thought package scope without <em>{}</em> is the same with it, but it is not.

{% highlight perl %}
package Foo {
    our $bar;      # declares $Foo::bar for rest of lexical scope
    $bar = 20;
}
package Bar {
    print $bar;    # prints nothing, as it refer to $bar, which is not defined  
}

{% endhighlight %}

Obviously, perldoc give detailed explaination.

<pre>
    package NAMESPACE
    package NAMESPACE VERSION
    package NAMESPACE BLOCK
    package NAMESPACE VERSION BLOCK
            Declares the BLOCK or the rest of the compilation unit as being in
            the given namespace. The scope of the package declaration is
            either the supplied code BLOCK or, in the absence of a BLOCK, from
            the declaration itself through the end of current scope (the
            enclosing block, file, or "eval"). That is, the forms without a
            BLOCK are operative through the end of the current scope, just
            like the "my", "state", and "our" operators. All unqualified
            dynamic identifiers in this scope will be in the given namespace,
            except where overridden by another "package" declaration or when
            they're one of the special identifiers that qualify into "main::",
            like "STDOUT", "ARGV", "ENV", and the punctuation variables.

            A package statement affects dynamic variables only, including
            those you've used "local" on, but [4mnot[0m lexically-scoped variables,
            which are created with "my", "state", or "our". Typically it would
            be the first declaration in a file included by "require" or "use".
            You can switch into a package in more than one place, since this
            only determines which default symbol table the compiler uses for
            the rest of that block. You can refer to identifiers in other
            packages than the current one by prefixing the identifier with the
            package name and a double colon, as in $SomePack::var or
            "ThatPack::INPUT_HANDLE". If package name is omitted, the "main"
            package as assumed. That is, $::sail is equivalent to $main::sail
            (as well as to $main'sail, still seen in ancient code, mostly from
            Perl 4).

            If VERSION is provided, "package" sets the $VERSION variable in
            the given namespace to a version object with the VERSION provided.
            VERSION must be a "strict" style version number as defined by the
            version module: a positive decimal number (integer or
            decimal-fraction) without exponentiation or else a dotted-decimal
            v-string with a leading 'v' character and at least three
            components. You should set $VERSION only once per package.

            See "Packages" in perlmod for more information about packages,
            modules, and classes. See perlsub for other scoping issues.
</pre>
