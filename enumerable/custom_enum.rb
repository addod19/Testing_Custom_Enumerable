# frozen_string_literal: true

module Enumerable
  private

  def convert_to_array(object)
    return object.to_a if object.respond_to?(:to_a)

    NoMehodError.new("Undefined method `#{caller_location[-2].label}` for #{object}: #{object.class}")
  end

  public

  def my_each
    as_array = convert_to_array(self)
    return as_array unless as_array.is_a?(Array)
    return to_enum(:my_each) unless block_given?

    0.upto(as_array.length - 1) { |i| yield(as_array[i]) }

    self
  end

  def my_each_with_index
    as_array = convert_to_array(self)
    return as_array unless as_array.is_a?(Array)
    return to_enum(:my_each_with_index) unless block_given?

    0.upto(as_array.length - 1) { |i| yield(as_array[i], [i]) }
    self
  end

  def my_select
    result = []
    as_array = convert_to_array(self)

    return as_array unless as_array.is_a?(Array)
    return to_enum(:my_select) unless block_given?

    0.upto(as_array.length - 1) { |i| result << as_array[i] if yield(as_array[i]) }

    result
  end

  def my_all?(*args)
    as_array = convert_to_array(self)
    len = as_array.length
    return as_array unless as_array.is_a?(Array)

    unless args.empty?
      puts `#{caller[0].split(':')[0..-2].join(':')} warning: arguments already passed` if block_given?
      return as_array.grep(args[0]).length == len
    end
    if block_given?
      0.upto(len - 1) { |i| return false unless yield(as_array[i]) }
    else
      0.upto(len - 1) { |i| return false if as_array[i].nil? || as_array[i] == false }
    end    
    true
  end

  def my_any?(*args)
    as_array = convert_to_array(self)
    len = as_array.length
    return as_array unless as_array.is_a?(Array)

    unless args.empty?
      puts `#{caller[0].split(':')[0..-2].join(':')} warning: arguments already passed` if block_given?
      return as_array.grep(args[0]).empty? ? false : true
    end
    if block_given?
      0.upto(len - 1) { |i| return true if yield(as_array[i]) }
    else
      0.upto(len - 1) { |i| return true unless as_array[i].nil? || as_array[i] == false }
    end
    false
  end

  def my_none?(*args)
    as_array = convert_to_array(self)
    len = as_array.length
    return as_array unless as_array.is_a?(Array)

    unless args.empty?
      puts `#{caller[0].split(':')[0..-2].join(':')} warning: arguments already passed` if block_given?
      return as_array.grep(args[0]).empty? ? true : false
    end
    if block_given?
      0.upto(len - 1) { |i| return false if yield(as_array[i]) }
    else
      0.upto(len - 1) { |i| return false unless as_array[i].nil? || as_array[i] == false }
    end
    true
  end

  def my_count(*args)
    as_array = convert_to_array(self)

    return as_array unless as_array.is_a?(Array)

    unless args.empty?
      puts `#{caller[0].split(':')[0..-2].join(':')} warning: arguments already passed` if block_given?
      return as_array.my_select { |v| v == args[0] }.length
    end

    return as_array.my_select { |v| yield v }.length if block_given?

    as_array.length
  end

  def my_map(*proc)
    result = []
    as_array = convert_to_array(self)
    len = as_array.length

    return as_array unless as_array.is_a?(Array)

    raise ArgumentError, 'Use Proc instead' unless block_given? || proc.is_a?(Proc)

    unless proc.empty?
      0.upto(len - 1) { |i| result << proc[0].call(as_array[i]) }
      result
    end
    return to_enum(:my_map) unless block_given?

    0.upto(len - 1) { |i| result << yield(as_array[i]) }
    result
  end

  def my_inject(*args)
    array = args + self
    return nil if array.empty?
    return array[0] if array.length == 1

    result = array[0]
    array[1..-1].each { |element| result = yield(result, element) }
    result
  end
end
def multiply_els(arr)
  arr.my_inject { |sum, num| sum * num }
end
