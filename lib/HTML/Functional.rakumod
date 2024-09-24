unit class HTML::Functional;

use HTML::Escape;

##### Declare Constants #####

#| viz. https://www.w3schools.com/tags/default.asp
constant @all-tags = <a abbr address area article aside audio b base bdi bdo blockquote body br
    button canvas caption cite code col colgroup data datalist dd del details dfn dialog div
    dl dt em embed fieldset figcaption figure footer form h1 h2 h3 h4 h5 h6 head header hgroup
    hr html i iframe img input ins kbd label legend li link main map mark menu meta meter nav
    noscript object ol optgroup option output p param picture pre progress q rp rt ruby s samp
    script search section select small source span strong style sub summary sup svg table tbody
    td template textarea tfoot th thead time title tr track u ul var video wbr>;

#| of which "empty" / "singular" tags from https://www.tutsinsider.com/html/html-empty-elements/
constant @singular-tags = <area base br col embed hr img input link meta param source track wbr>;

##### HTML Escape #####

multi prefix:<^>(Str:D() $s) is export {
    escape-html($s)
}

sub text(Str:D() $s) is export {
    escape-html($s)
}

##### HTMX Tag Export #####

sub attrs(%h) is export {
    +%h ?? (' ' ~ %h.map({.key ~ '="' ~ .value ~ '"'}).join(' ') ) !! ''
}

sub opener($tag, *%h) is export {
    "\n" ~ '<' ~ $tag ~ attrs(%h) ~ '>'
}

sub inner(@inners) is export {
    given @inners {
        when * == 0 {   ''   }
        when * == 1 { .first }
        when * >= 2 { .join  }
    }
}

sub closer($tag, :$nl) is export {
    ($nl ?? "\n" !! '') ~
    '</' ~ $tag ~ '>'
}

sub do-regular-tag($tag, *@inners, *%h) is export {
    my $nl = @inners >= 2;
    opener($tag, |%h) ~ inner(@inners) ~ closer($tag, :$nl)
}

sub do-singular-tag($tag, *%h) is export {
    "\n" ~ '<' ~ $tag ~ attrs(%h) ~ ' />'
}


# put in all the tags programmatically
# viz. https://docs.raku.org/language/modules#Exporting_and_selective_importing

my @regular-tags = (@all-tags (-) @singular-tags).keys;  #Set difference (-)

my package EXPORT::DEFAULT {
    for @regular-tags -> $tag {
        OUR::{'&' ~ $tag} := sub (*@inners, *%h) { do-regular-tag( "$tag", @inners, |%h ) }
    }

    for @singular-tags -> $tag {
        OUR::{'&' ~ $tag} := sub (*%h) { do-singular-tag( "$tag", |%h ) }
    }
}

