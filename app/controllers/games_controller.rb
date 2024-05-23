require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @inputs = params[:words]
    @grid = params[:grid_words]

    if !valid_words(@inputs)
      @result = "Sorry, but #{@inputs.upcase} is not a valid word."
    elsif !letters_in_grid(@inputs, @grid)
      @result = "Sorry, but #{@inputs.upcase} is not built out from original grid."
    else
      valid_words(@inputs) && letters_in_grid(@inputs, @grid)
        @result = "Congratulations! #{@inputs.upcase} is valid according to the grid and is an English word!"
    end
  end

  def valid_words(answer)
    document = URI.open("https://dictionary.lewagon.com/#{answer}").read
    valid_result = JSON.parse(document)
    valid_result['found']
  end

  def letters_in_grid(inputs, grid)
    inputs.chars.all? do |input|
      grid.include?(input)
    end
  end
end
