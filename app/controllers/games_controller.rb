require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = generate_grid(9)
  end

  def generate_grid(grid_size)
    new_grid = Array.new(grid_size) { ('A'..'Z').to_a.sample }
  end

  def new
    @letters = generate_grid(9)
  end

  def score
    @result = english_word?(params[:word])
    r = params[:word].length
    @count = new_grid.length
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def included?(guess)
    guess.chars.all? { |letter| guess.count(letter) <= @letters.count(letter) }
  end
end
