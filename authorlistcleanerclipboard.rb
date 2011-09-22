#!/usr/bin/ruby
# 
# authorlistcleanerclipboard by Morten Johannes Ervik, CIN/IARC, ervikm@iarc.fr
# (Pointed out as a good idea by Neela Guha, IMO/IARC, guhan@iarc.fr)
# 
# Usage: Copy your authorlist and institutions to the clipboard, run this script and an html of updated numbers is generated.
#
# Requirements: Ruby (tested on 1.9.2) and the clipboard gem (gem install clipboard) (and potentially the launch gem)
#
# Format: Autorlist has to follow a standard format, i.e. 
#   Morten Ervik1, Dirk Gently2,3, Ford Prefect3,4
#   [1] IARC; [2] Holistic Detective Agency; [3] DNA; [4] The Guide  
#
# Feel free to do whatever you want with this little script on your own risk etc. It is just a quick hack, so there's 
# not any error control or flexibility in input/output format.
require 'clipboard'
require 'launchy'
require 'tempfile'
require './authorlistcleanercore.rb'
# clean things coming in 
html_string = clean Clipboard.paste.encode("UTF-8")
# Write the html to a file
out_file = Tempfile.new(['autorlist','.html'])
out_file.write(html_string)
out_file.flush
filepath = "file:///#{out_file.path}"
begin
  Launchy.open(filepath)
rescue Exception=>e
  puts "Launchy not installed...\n"+"Here's the html:\n" + html_string
  puts "And here's the temp file:" + out_file.path
  sleep(1000)
end