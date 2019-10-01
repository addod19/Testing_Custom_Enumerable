require "./enumerable/custom_enum.rb"

RSpec.describe Enumerable do
  let!(:array_one) { [1,2,3,4,5] }
  let!(:array_two) { [2,4,6] }  
  let!(:array_three) { [] }
  let!(:array_four) { [true,false,nil,1,'string'] }
  let!(:array_five) { {1 => 'one', 2 => 'two', 3 => 'three', 4 => 'four'} }
  let!(:array_six) { ['kwame', 'kojo', 'yaw']}
  let!(:array_bool_1) { [false, false, true] }

  describe "#my_each" do
    context " return elements of an array " do
      it " return each element of array " do
        expect(array_one.my_each { |v| v }).to eql([1,2,3,4,5])
      end
    end
  end

  describe "#my_all?(arg = nil)" do
    it "It return true if array is empty and neither a block or agument is passed" do
     
     expect( array_three.my_all? ).to eql(true)
    end
    it "It return false if all element in the array are not of the same boolean value and neither a block or argument is given" do
     
     expect( array_bool_1.my_all? ).to eql(false)
    end
    
    it "It return true if all element in the array are of the same boolean value and neither a block or argument is given" do
     
     expect( array_bool_1.my_all? ).to eql(false)
    end
    it "It return true if all element in the array is of the same type as the argument passed " do
                          
     expect( array_one.my_all?( Integer ) ).to eql(true)
    end

    it "It return true based on the codition specified in the block when give a block" do
                          
     expect( array_six.my_all? { |word| word.length >= 4 }  ).to eql(false)
    end

    
    it "It return false if none of the above condition is not true" do
                          
     expect( array_six.my_all? { |word| word.length == 3 }  ).to eql(false)
    end

  end

end