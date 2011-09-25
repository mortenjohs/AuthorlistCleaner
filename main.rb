#!/usr/bin/ruby
# 
# authorlistcleaner by Morten Johannes Ervik, CIN/IARC, ervikm@iarc.fr
# (Pointed out as a good idea by Neela Guha, IMO/IARC, guhan@iarc.fr)
# 
# Usage: Copy your authorlist to the webapp, click clean.
#
# Requirements: Ruby (tested on 1.9.2) and the 'sinatra' and 'slim' gems - optionally also the lauchy gem.
#
# Format: Autorlist has to follow a standard format, i.e. 
#   Morten Ervik1, Dirk Gently2,3, Ford Prefect3,4
#   [1] IARC; [2] Holistic Detective Agency; [3] DNA; [4] The Guide  
#
# Feel free to do whatever you want with this little script on your own risk etc. It is just a quick hack, so there's 
# not any error control or flexibility in input/output format.
require 'sinatra'
require 'slim'
require './authorlistcleanercore.rb'

get '/' do
  slim :index
end

post '/' do
  clean params[:text]
end

url_string = "http://localhost:4567"

begin
  require 'launchy'
  Launchy.open(url_string)
rescue Exception=>e
  puts "Launchy not installed...\n"+"Here's the URL:\n" + url_string
end