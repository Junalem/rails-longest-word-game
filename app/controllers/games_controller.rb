require 'open-uri'
require 'json'

class GamesController < ApplicationController
  Rails.application.config.session_store :cookie_store, key: '_your_app_session'

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    raise
    if params[:word].chars.all? { |letter| params[:letters].include?(letter.upcase) }
      if english_word?(params[:word])
        @responce = "Congratulation! #{params[:word].capitalize} is valid eanglish word"
      else
        @responce = "Sorry but #{params[:word].capitalize} does not seem to be a valid English word"
      end
    else
      @responce = "Sorry but #{params[:word].capitalize} can't be bild out of #{params[:letters]}"
    end
    @score = params[:word].length * 0.5
    session[:score] += @score
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
