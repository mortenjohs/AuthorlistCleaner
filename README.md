# AuthorlistCleaner

**AuthorlistCleaner** is a tool to help writers of scientific articles, for some reason forced not to use LaTeX, to easily manipulate long lists of authors and institutions. Change order and regenerate numbers and order of institutions involved.

For now authorlists have to follow the following format:

    Morten Ervik1, Dirk Gently2,3, Ford Prefect3,4
    [1] IARC; [2] Holistic Detective Agency; [3] DNA; [4] The Guide

Setup
=====
Install the gems needed for the version you want to use.

For the web based version you need the sinatra web framework and the slim template language ( https://github.com/stonean/slim ):

    gem install 'sinatra'
    gem install 'slim'

For the clipboard version you need janelis clipboard tool ( https://github.com/janlelis/clipboard ) and (optionally) launchy ( https://github.com/copiousfreetime/launchy ):

    gem install 'clipboard'
    gem install 'launchy'

Usage
=====

For the web based version:

    ruby main.rb

Point your browser to http://localhost:4567, paste your list of authors and instititions there and click Clean.

For the clibpoard version, copy your list of authors and institutions to the clipboard and then:

    ruby authorlistcleanerclipboard.rb

This will generate the necessary html to paste back in your editor.

TODO
====
User defined regexps

Copyright
=========
(c) 2011 Morten Ervik, released under the BSD license