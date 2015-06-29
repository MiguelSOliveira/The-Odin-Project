class CodeMaker

  def initialize code_length
    @code_length = code_length
  end

  def self.code
    @@code
  end

  def generate_code
    @@code = ""
    @code_length.times do |i|
      @@code << rand(1..6).to_s
    end
    @@code
  end

  private
  def compare_code guessed_code
    right_places = ""
    wrong_places = ""
    guessed_code.split("").each_with_index do |value, index|
      right_places << index.to_s if @@code[index] == value
      wrong_places << index.to_s if @@code[index] != value and @@code.include? value
    end
    return [right_places, wrong_places]
  end
end
