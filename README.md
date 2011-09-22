Setup
=====
Install the gems needed for the version you want to use.

For the web based version:

    gem install 'sinatra'
    gem install 'slim'

For the clipboard version:

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