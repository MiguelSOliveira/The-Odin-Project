require_relative 'spec_helper'

describe "Sort" do

  it "sorts correctly" do
    expect(bubble_sort [3,2,1]).to eq [1,2,3]
  end

  it "remains sorted if given a sorted array" do
    expect(bubble_sort [1,2,3]).to eq [1,2,3]
  end

  it "maintains the same size" do
    expect((bubble_sort [3,2,1]).length).to eq [3,2,1].length
  end

  it "returns [] if given []" do
    expect(bubble_sort []).to eq []
  end

  it "returns same array if given an array with 1 element" do
    expect(bubble_sort [1]).to eq [1]
  end

  it "works with duplicate numbers" do
    expect(bubble_sort [2,2,1]).to eq [1,2,2]
  end

  it "works with negative numbers" do
    expect(bubble_sort [2,-1]).to eq [-1,2]
  end

  it "works with letters" do
    expect(bubble_sort ['b', 'a']).to eq ['a','b']
  end
end
