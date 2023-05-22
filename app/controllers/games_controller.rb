require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    @new = Array('A'..'Z').sample(10)
  end

  def score
    @grid = params[:new].split(',')
    @message = "Congratulations! #{@words} is a valid English word!"
    @words = params[:word].upcase.split('')
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    word_serialized = URI.open(url).read
    word = JSON.parse(word_serialized)
    @words.each do |letter|
        index = @grid.index(letter)
        if index && word["found"] == true && word["length"] == @words.size
          @grid.delete_at(index)
        elsif index && word["found"] == false && word["length"] == @words.size
          # @grid.delete_at(index)
          @message = "Sorry but #{@words} does not seem to be a valid English word..."
        else
          @message = "Sorry but #{@words} can't be built out of #{@grid}"
        end
      end
  end
end
