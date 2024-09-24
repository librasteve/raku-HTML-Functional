HTML::Functional
================

DESCRIPTION
===========

Provides a Functional interface style for HTML tags and attributes.

Best practice is to HTML::Escape all tag inner text, two equivalent options are provided for this:
- the _text_ subroutine ```text('mytext')```
- the caret prefix ```^'mytext'```

IMPORTANT:
HTML::Escape is not applied by default to inner tags in order to facilitate the flexible application of Raku quoting constructs such as ```{strong 'DMI'}``` (as shown in the synopsis). Therefore care must be taken to always apply HTML::Escape particularly where this is stored in a variable and/or comes from tainted user input.

Contributions welcome - by PR please.

TODOS
=====
 - [ ] add ```my Str = 'xyz' but Tainted``` class / constraint

SYNOPSIS
========

```raku
#!/usr/bin/env raku
use v6.d;

use HTML::Functional;

my $head = head [
    meta( :charset<utf-8> ),
    meta( :name<viewport>, :content<width=device-width, initial-scale=1> ),
    meta( :name<description>, :content<raku does htmx> ),

    title( "Raku HTML::Functional" ),

    script( src  => "https://unpkg.com/htmx.org@1.7.0", ),

    link(   rel  => "stylesheet",
            href => "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css",
    ),
    style(
        q:to/END/;
            .jumbotron {
              background-color: #e6ffe6;
              text-align: center;
            }
        END
    ),
];

my $body = body [
    div( :class<jumbotron>, [
        h1("Welcome to Dunder Mifflin!"),                          #use parens to stop <h1> slurping <p>
        p  "Dunder Mifflin Inc. (stock symbol {strong 'DMI'}) " ~
            q:to/END/;
            is a micro-cap regional paper and office
            supply distributor with an emphasis on servicing
            small-business clients.
            END
    ]),

    p :hx-get<https://v2.jokeapi.dev/joke/Any?format=txt&safe-mode>,
        "Click Me",

    p ^'<div class="content">Escaped & Raw HTML!</div>',
];

my $html = html :lang<en>, [
    $head,
    $body,
];

say "<!doctype html>$html";
```

AUTHOR
======

librasteve <librasteve@furnival.net>

COPYRIGHT AND LICENSE
=====================

Copyright (c) 2024 Henley Cloud Consulting Ltd.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.






