require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    # raise
    if params[:word].chars.all? { |letter| params[:letters].include?(letter.upcase) }
      if english_word?(params[:word])
        @responce = "Congratulation! #{params[:word]} is valid eanglish word"
      else
        @responce = "Sorry but #{params[:word]} does not seem to be a valid English word"
      end
    else
      @responce = "Sorry but #{params[:word]} can't be bild out of #{params[:letters]}"
    end
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
