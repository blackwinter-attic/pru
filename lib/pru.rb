require 'pru/core_ext'

module Pru

  extend self

  VERSION = File.read(File.join(File.dirname(__FILE__), '..', 'VERSION')).strip

  def map(io, code)
    String.class_eval <<-RUBY, __FILE__, __LINE__ + 1
      def _pru(i)
        #{code}
      end
    RUBY

    i = 0
    io.each_line do |line|
      i += 1
      result = line[0..-2]._pru(i)
      if result == true
        yield line
      elsif result.is_a?(Regexp)
        yield line if line =~ result
      elsif result
        yield result
      end
    end
  end

  def reduce(array, code)
    Array.class_eval <<-RUBY, __FILE__, __LINE__ + 1
      def _pru
        #{code}
      end
    RUBY
    array._pru
  end

end
