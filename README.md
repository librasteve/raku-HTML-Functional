**WORK IN PROGRESS**

HTML::Functional
================



SYNOPSIS
========

```raku
use HTML::Functional;
```

DESCRIPTION
===========

Provides a Functional interface style for HTML tags and attributes.


TODOS
=====

- [x] move out to HTML::Functional
- [x] Do the ¶ term for HTML::Escape
- [x] unify tag routines with HTML::OO
- [ ] add pico tags (or tag factory)

Contributions welcome - by PR please if possible.

AUTHOR
======

librasteve <librasteve@furnival.net>

COPYRIGHT AND LICENSE
=====================

Copyright 2024 librasteve

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.





SYNOPSIS
========

```raku
use HTMX;

my $head = head [
    meta( :charset<utf-8> ),
    meta( :name<viewport>, :content<width=device-width, initial-scale=1> ),
    meta( :name<description>, :content<raku does htmx> ),

    title( "Raku HTMX" ),

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
];

my $html = html :lang<en>, [
    $head,
    $body,
];

say "<!doctype html>$html";
```



TODOS
=====

#### Minimum Lovable Product (`MLP`)

- [x] Get a definitive list of HTML tags
- [x] Export them so that `h1("text")` makes `<h1>text</h1>` and so on
- [x] Pass and format the HTMX attributes
- [x] Bring in synopsis from design
- [ ] Make a parse script (& instructions how to watch a dir)
- [x] Write some tests
- [ ] Write some docs in POD6
- [ ] Release with App::Mi6
- [ ] Publish as raku-htmx on the htmx Discord

#### Follow On

- [ ] consider adding back end template to this module (like this https://github.com/Konfuzian/htmx-examples-with-flask/tree/main)
- [ ] CSS - try some alternatives, read some stuff, make a plan
- [ ] Cro - how to integrate HTMX Static pages with Cro backend
- [ ] Hummingbird - ditto for HB
- [ ] Attribute checking (need deeper list of attr names and set of types)



