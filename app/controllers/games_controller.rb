require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do |letter|
      letter = ('A'..'Z').to_a.sample
      @letters << letter
    end
  end

  def score
    @letters = params[:letters].split
    @result = params[:result].upcase.chars
    url = "https://wagon-dictionary.herokuapp.com/#{params[:result]}"
    user_serialized = URI.open(url).read
    @compare = JSON.parse(user_serialized)

  if @compare["found"] && @result.all?{ |letter| @result.count(letter) <= @letters.count(letter) }
    @points = "Nice"
  else
    @points = "Go again"
  end
  end
end
