#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'readline'
require 'image_editor'

loop do
  line = Readline::readline('image_editor >> ')
  break if line.nil?
  Readline::HISTORY.push(line)
  begin
    ImageEditor::Router.recognize(line)
  rescue ImageEditor::TerminateError
    puts "Bye..."
    exit(0)
  rescue Exception => e
    puts e
  end
end


