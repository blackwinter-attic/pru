class Array

  # http://madeofcode.com/posts/74-ruby-core-extension-array-sum
  def sum(method = nil)
    if block_given?
      raise ArgumentError, 'You cannot pass both a block and a method' if method
      inject(0) { |s, x| s + yield(x) }
    elsif method
      inject(0) { |s, x| s + x.send(method) }
    else
      inject(0) { |s, x| s + x }
    end
  end unless method_defined?(:sum)

  def mean(method = nil, &block)
    sum(method, &block) / size.to_f
  end unless method_defined?(:mean)

  def grouped
    group_by { |x| x }
  end unless method_defined?(:grouped)

  def group_by
    hash = {}
    each { |x| hash[yield(x)] = x }
    hash
  end unless method_defined?(:group_by)

end
