Mono binding for D
==================

libmono-d is a binding to Mono's embedding API. It
allows D applications to embed Ecma 335-compliant
code (C#, F#, etc).

Building
--------

You build libmono-d by using Waf:

    $ waf configure --lp64=true --mode=release
    $ waf build
    $ waf install

You can of course adjust the parameters to configure
as needed.
