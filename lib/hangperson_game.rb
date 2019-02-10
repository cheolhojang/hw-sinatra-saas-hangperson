class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = '' 
  end
  
  # displays the formatted word after guesses have been made
  def word_with_guesses
    result = ''
    @word.split('').each do |char|
      if @guesses.include? char
        result << char
      else
        result << '-'
      end
    end
    
    return result
  end
  
  def check_win_or_lose
    if word_with_guesses.downcase == @word.downcase
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
  end
  
  def guess(letter)
    if letter == nil || !(letter.class == String && letter =~ /^[A-z]$/i)
      raise ArgumentError
    end
    letter.downcase!
    if @guesses.include?(letter) || @wrong_guesses.include?(letter)
      return false
    end
    if letter.length != 1
      return false
    end
    if @word.include? letter
      @guesses << letter
    else
      @wrong_guesses << letter
    end
    return true
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  

end