require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(10)] }
  end

  def score
    @word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"

    html_file = open(url).read
    html_doc = JSON.parse(html_file)
    @found = html_doc["found"]
    @error = html_doc["error"]
    @letters = (0...10).map { ('a'..'z').to_a[rand(10)] }

    if @found == false
      @answer = "Sorry but #{@word.upcase} does not seem to be an English word..."
    elsif @word.include?(@letters.to_s)
      @answer = "Sorry but #{@word.upcase} can't be built out of #{@letters.join(" , ").upcase}"
      raise
    else
      @answer = "Congratulations! #{@word.upcase} is a valid English word!"
    end
  end
end
