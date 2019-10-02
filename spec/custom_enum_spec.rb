# frozen_string_literal: true

require './enumerable/custom_enum.rb'

RSpec.describe Enumerable do
  let!(:array_one) { [1, 2, 3, 4, 5] }
  let!(:array_two) { [2, 4, 6] }
  let!(:array_three) { [] }
  let!(:array_four) { [true, false, nil, 1, 'string'] }
  let!(:array_five) { { 1 => 'one', 2 => 'two', 3 => 'three', 4 => 'four' } }
  let!(:array_six) { %w[kwame kojo yaw] }
  let!(:array_bool_1) { [false, false, true] }

  describe '#my_each' do
    context ' return elements of an array ' do
      it ' return each element of array ' do
        expect(array_one.my_each { |v| v }).to eql([1, 2, 3, 4, 5])
      end
      it ' It returns each key or value in hash when given a block with two parameter ' do
        expect(array_five.my_each { |_a, b| b }).to eql(array_five)
      end
    end
  end

  describe '#my_all?(arg = nil)' do
    it 'It return true if array is empty and neither a block or agument is passed' do
      expect(array_three.my_all?).to eql(true)
    end
    it 'It return false if all element in the array are not of the ' do
      expect(array_bool_1.my_all?).to eql(false)
    end
    it 'It return true if all element in the array are of the same boolean' do
      expect(array_bool_1.my_all?).to eql(false)
    end
    it 'It return true if all element in the array is of the same type as the argument passed ' do
      expect(array_one.my_all?(Integer)).to eql(true)
    end
    it 'It return true based on the codition specified in the block when give a block' do
      expect(array_six.my_all? { |word| word.length >= 4 }).to eql(false)
    end
    it 'It return false if none of the above condition is not true' do
      expect(array_six.my_all? { |word| word.length == 3 }).to eql(false)
    end
  end

  describe '#my_map' do
    it 'It returns each elements in an Array when one parameter is passed in the block' do
      expect(array_one.my_map { |e| e }).to eql([1, 2, 3, 4, 5])
    end
    it 'It returns a modified array based  on the condition specified in the block ' do
      expect(array_one.my_map { |e| e * 2 }).to eql([2, 4, 6, 8, 10])
    end
    it 'It returns an array  of true or false  based  on the condition specified in the block ' do
      expect(array_one.my_map { |e| e < 3 }).to eql([true, true, false, false, false])
    end
    it 'It returns the key and the value of each element in an array by passing two arguments to the block ' do
      expect(array_five.my_map { |_e, f| f }).to eql(%w[one two three four])
    end
  end
  
  describe " #my_count(para = nil) " do
    it "It returns the number of elements in array when no parameter is given and no block is passed " do
      expect(array_one.my_count ).to eql( 5 )
    end
    it "It returns the number of the argument that exist in the array it operates upon,when no block is given " do
      expect(array_bool_1.my_count(false) ).to eql( 2 )
    end
    it "It returns the number of that exist in the array based on the condition specified in the block " do
      expect(array_two.my_count { |a| a  == 6 } ).to eql( 1 )
    end
  end

  describe "#my_select" do
    it "It returns a new array based on the value specified in the in the block" do
      expect( array_one.my_select{ | a | a > 2} ).to eql([3,4,5])
    end
  end

  describe "#my_inject(param = nil)" do
    it "It returns a value based on the operation specified in the block whilst no argument is given" do
      expect( array_one.my_inject { |sum,value| sum + value} ).to eql(25)
    end
    it "It returns a value based on the operation specified in the block whilst and the argument is given" do
      expect( array_one.my_inject(1) { |sum,value| sum + value} ).to eql(10)
    end
  end
end
