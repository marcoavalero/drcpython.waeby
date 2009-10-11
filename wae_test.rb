$:.unshift File.join(File.dirname(__FILE__))

require 'test/unit'
require 'rubygems'
require 'treetop'
require 'polyglot'

Treetop.load "waeg"


class Wae_Grammar_Test < Test::Unit::TestCase
  def setup
    @parser = WaeParser.new
  end 

  def test_num
    assert(@parser.parse('0'))
    assert(@parser.parse('243090009234'))
    assert_equal(5, @parser.parse('5').value)
  end

  def test_id
    assert @parser.parse('d')
    assert !@parser.parse('D')
    assert !@parser.parse('xx')
    assert_equal 'x', @parser.parse('x').name
  end

  def test_neg
    assert(@parser.parse('-5'))
    assert(@parser.parse('--x'))
    assert_equal -3455, @parser.parse('-3455').value
  end

  def test_addition
    assert(@parser.parse('{- 6 5}'))
    assert @parser.parse('{+6 5333 }')
    assert_equal 7, @parser.parse('{+ 4 3}').value
    assert_equal 28, @parser.parse('-{+ {- 32 -5} {+ -{+ 32 5} -28}}').value
  end

  def test_assignment
    assert @parser.parse('{with {x 5} x}')
    assert @parser.parse('{+ { with { x 5 } x} {with { y 4} y } }')
    assert( @parser.parse('-{+ {with {x 5} x} {with {y 4} {+ x y}}}'))
  end
end
