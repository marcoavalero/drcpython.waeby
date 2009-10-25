require 'rubygems'
require 'treetop'
require 'polyglot'

Treetop.load "waeg"

class Runtime
  def initialize
    @wae = WaeParser.new
  end

  def start
    begin
      while true
        print 'WAE > '
        input = gets.chomp
        puts @wae.parse(input).eval
      end
    rescue
      begin
        puts @wae.parse(input).name
        rescue
        if !input.end_with? ";" then
          puts "Syntax Error: Missing ';'"
        else
          puts "Syntax Error: Unrecognized Token"
        end
      end
      retry
    end
  end

end

Runtime.new.start
