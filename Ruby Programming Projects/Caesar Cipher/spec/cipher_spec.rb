require_relative 'spec_helper'

describe "Cypher" do
  it "shifts correctly" do
    @sentence = caesar_cipher "Hello", 2
    expect(@sentence).to eq "Jgnnq"
  end

  it "loops correctly through the alphabet" do
    @sentence = caesar_cipher "z", 1
    expect(@sentence).to eq "a"
  end

  it "does not change spaces, punctuation or numbers" do
    @sentence = caesar_cipher " .2", 5
    expect(@sentence).to eq " .2"
  end

  it "does not change casing of letters" do
    @sentence = caesar_cipher "A", 0
    expect(@sentence).to eq "A"
  end

  it "allows only positive shifts" do
    @sentence = caesar_cipher "l", -1
    expect(@sentence).to eq "l"
  end
end
