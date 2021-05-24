module Enumerable
  def my_each
    count = 0
    while count < self.length
      yield(self[count])
      count += 1
    end
  end

  def my_each_with_index
    count = 0
    while count < self.length
      yield(self[count], count)
      count += 1
    end
  end

  def my_select
    results = []
    my_each do |element|
      results << element if yield(element)
    end
    results
  end

  def my_all?(&block)
    results = my_select(&block)
    return true if results.length == self.length

    false
  end

  def my_any?(&block)
    return true if my_select(&block).length > 0

    false
  end

  def my_none?(&block)
    return false if my_select(&block).length > 0

    true
  end

  def my_count(&block)
    my_select(&block).length
  end

  def my_map
    result = []
    my_each do |element|
      if block_given?
        result << yield(element)
      else
        result << element
      end
    end
    result
  end

  def my_inject
    result = self[0]
    my_each_with_index do |element, index|
      next if index.zero?

      result = yield(result, element)
    end
    result
  end

end

def multiply_els(array)
  array.my_inject { |accumulator, item| accumulator * item }
end

puts 'my_each vs. each'
numbers = [1, 2, 3, 4, 5]
numbers.my_each { |item| puts item }
numbers.each { |item| puts item }

puts "\nmy_each_with_index vs. each_with_index"
numbers.my_each_with_index { |item, i| puts "#{i}: #{item}" }
numbers.each_with_index { |item, i| puts "#{i}: #{item}" }

puts "\nmy_select vs. select"
p numbers.my_select { |item| item == 1 }
p numbers.select { |item| item == 1 }

puts "\nmy_all? vs. all?"
numbers = [1, 1, 1, 1, 1, 1]
p numbers.my_all? { |item| item == 1 }
p numbers.all? { |item| item == 1 }
p numbers.my_all? { |item| item == 2 }
p numbers.all? { |item| item == 2 }


puts "\nmy_any? vs. any?"
numbers = [1, 1, 3, 4, 5]
p numbers.my_any? { |item| item == 1 }
p numbers.any? { |item| item == 1 }
p numbers.my_any? { |item| item == 2 }
p numbers.any? { |item| item == 2 }

puts "\nmy_none? vs none?"
numbers = [1, 1, 3, 4, 5]
p numbers.my_none? { |item| item == 1 }
p numbers.none? { |item| item == 1 }
p numbers.my_none? { |item| item == 2 }
p numbers.none? { |item| item == 2 }

puts "\nmy_count vs. count"
p numbers.my_count { |item| item == 1 }
p numbers.count { |item| item == 1 }

puts "\nmy_map vs. map"
p numbers.my_map { |item| item * 2 }
p numbers.map { |item| item * 2 }

puts "\nmy_inject vs. inject"
numbers = [1, 2, 3, 4, 5]
p numbers.my_inject { |accumulator, item| accumulator * item }
p numbers.inject { |accumulator, item| accumulator * item }

puts "\nmultiply_els"
p multiply_els([2, 4, 5])
