require 'pru/core_ext'

module Pru

  extend self

  VERSION = File.read(File.join(File.dirname(__FILE__), '..', 'VERSION')).strip

  def map(io, code)
    io.each_line { |line|
      line.chomp!

      case result = line.instance_eval(code) or next
        when true   then yield line
        when Regexp then yield line if line =~ result
        else             yield result
      end
    }
  end

  def reduce(array, code)
    array.instance_eval(code)
  end

end
