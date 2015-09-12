require_relative 'spec_helper'

describe Enumerable do
  subject { [1,2,3,4,5] }

  describe "#my_each" do
    context "when using blocks" do
      it "returns what is given" do
        expect(subject.my_each { |x| }).to eq subject
      end
    end

    context "when not using blocks" do
      it "returns nil" do
        expect(subject.my_each).to be_nil
      end
    end
  end

  describe "#my_select" do
    context "when using blocks" do
      it "selects all numbers larger than zero" do
        expect(subject.my_select { |x| x > 0 }).to eq subject
      end
    end

    context "when not using blocks" do
      it "returns nil" do
        expect(subject.my_select).to be_nil
      end
    end
  end

  describe "#my_all" do
    context "when using blocks" do
      it "returns true if all values follow the condition" do
        expect(subject.my_all { |x| x > 0 }).to be true
      end

      it "returns false if there's a value that doesnt follow the condition" do
        expect(subject.my_all { |x| x > 4 }).to be false
      end
    end

    context "when not using blocks" do
      it "returns nil" do
        expect(subject.my_all).to be_nil
      end
    end
  end

  describe "#my_any" do
    context "when using blocks" do
      it "returns true if there is at least one value that matches the condition" do
        expect(subject.my_any { |x| x > 4 }).to be true
      end

      it "returns false if none of the values match the condition" do
        expect(subject.my_any { |x| x > 5 }).to be false
      end
    end

    context "when not using blocks" do
      it "returns nil" do
        expect(subject.my_all).to be_nil
      end
    end
  end

  describe "#my_none" do
    context "when using blocks" do
      it "returns true if none of the values match the condition" do
        expect(subject.my_none { |x| x > 10 }).to be true
      end

      it "returns false if some of the values match the condition" do
        expect(subject.my_none { |x| x < 2 }).to be false
      end
    end
  end

  describe "my_count" do
    context "when using blocks" do
      it "returns the correct counter for a condition" do
        expect(subject.my_count { |x| x > 4 }).to eq 1
      end
    end

    context "when not using blocks" do
      it "returns the length of the array" do
        expect(subject.my_count).to eq subject.length
      end
    end
  end
end
