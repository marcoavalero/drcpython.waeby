require 'rubygems'
require 'treetop'

Treetop.load "waeg"

class Runtime
  def initialize
    @wae = WaeParser.new
  end

  def start
    while true
      print 'WAE > '
      input = gets.chomp
      if @wae.parse(input)
        puts 'Valid WAE'
      else
        puts 'Invaled WAE'
      end
    end
  end

end

Runtime.new.start
