# frozen_string_literal: true

module EnumerableHelper
  def check_true(len, as_array)
    if block_given?
      0.upto(len - 1) { |i| return true if yield(as_array[i]) }
    else
      0.upto(len - 1) { |i| return true unless as_array[i].nil? || as_array[i] == false }
    end
    false
  end

  def check_false(len, as_array)
    if block_given?
      0.upto(len - 1) { |i| return false if yield(as_array[i]) }
    else
      0.upto(len - 1) { |i| return false unless as_array[i].nil? || as_array[i] == false }
    end
    true
  end
end
