class GamesController < ApplicationController
  def new
    @letters = generate_grid(9)
  end

  def score
    if included?(params[:word])
      if english_word?(params[:word])
      @result = "<b>Congratulations!</b> #{params[:word].upcase} is a valid English word"
      else
      @result = "Sorry but #{params[:word].upcase} doesn't seem to be a valid English word..."
      end
    else
      @result = "Sorry but #{params[:word].upcase} can't be build out of #{@letters}"
    end
  end

  private

  def generate_grid(grid_size)
    Array.new(grid_size) { ('A'..'Z').to_a.sample }
  end

  def included?(word)
    # word.chars.all? { |letter| word.count(letter) <= @letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
