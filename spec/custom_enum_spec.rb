require_relative "../enumerable/custom_enum.rb"

RSpec.describe Enumerable do
  let!(:array_one) { [1,2,3,4,5] }
  let!(:array_two) { [2,4,6] }  
  let!(:array_three) { [] }
  let!(:array_four) { [true,false,nil,1,'string'] }
  let!(:array_five) { {1 => 'one', 2 => 'two', 3 => 'three', 4 => 'four'} }

  describe " my_each " do
    context " return elements of an array " do
      it " return each element of array " do
        expect(array_one.my_each { |v| v }).to eql([1,2,3,4,5])
      end
    end
  end

end