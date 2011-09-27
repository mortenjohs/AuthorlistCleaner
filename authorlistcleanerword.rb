#!/usr/bin/ruby
# 
# authorlistcleaner by Morten Johannes Ervik, CIN/IARC, ervikm@iarc.fr
# (Pointed out as a good idea by Neela Guha, IMO/IARC, guhan@iarc.fr)
# 
# Usage: Highlight your authorlist and institutions in Word, run this script and institution numbers will be updated. This could be mapped to a shortcut-key, I guess.
#
# Requirements: Ruby (tested on 1.9.2) and Word for Windows (not Starter Edition as that does not support automation).
#
# Format: Autorlist has to follow a standard format, i.e. 
#   Morten Ervik1, Dirk Gently2,3, Ford Prefect3,4
#   [1] IARC; [2] Holistic Detective Agency; [3] DNA; [4] The Guide  
#
# Feel free to do whatever you want with this little script on your own risk etc. It is just a quick hack, so there's 
# not any error control or flexibility in input/output format.
#
require 'win32ole'
require './authorlistcleanercore.rb'

# connect to word
word = WIN32OLE.connect('Word.Application')
document = word.ActiveDocument

# define some helper functions
def delete_last_n_characters_in_word(word,n)
  start = word.Selection.Start
  word.Selection.Start = start - n
  word.Selection.End = start
  word.Selection.Delete
end

# clean things coming in
html_string = clean word.Selection.Text.encode("UTF-8")

# a hack to split it between authors and institutions
parts = html_string.split("<br><br>")

# every second string is now superscript
auts = parts[0].split(/\<\/*sup\>/)

# strip html tags
auts = auts.map {|a| a.gsub(/<\/?[^>]*>/, "")}
insts_string = parts[1].gsub(/<\/?[^>]*>/, "")

# set bold in word
word.Selection.Font.Bold = true

# put authors and indexes back in word
(0..auts.length/2).each do |n|
  word.Selection.TypeText("#{auts[n*2]}")
  word.Selection.Font.Superscript = true
  word.Selection.TypeText("#{auts[n*2+1]}")
  word.Selection.Font.Superscript = false
end

word.Selection.TypeText("\n\n")
word.Selection.TypeText(insts_string)

puts "\nNow things should be OK and you can close this window.\n\nThank you for using the authorlistcleaner!\n\nMorten"
sleep (100)
