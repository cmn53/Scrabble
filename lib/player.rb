require_relative "scoring.rb"
require_relative "tilebag.rb"

module Scrabble
  class Player
    attr_reader :name, :words_played, :score, :tiles
    def initialize(name)
      @name = name.to_s
      @words_played = []
      @score = 0
      @tiles = []
    end

    def plays
      return @words_played
    end

    def play(word)
      @words_played << word
      # word.split("").each do |letter|
      #   i = @tiles.find_index(letter)
      #   @tiles.delete_at(i)
      # end
      word_score = Scoring.score(word)
      @score += word_score
      if won? == true
        return false
      else
        return word_score
      end
    end

    def total_score
      return @score
    end

    def won?
      if total_score > 100
        return true
      else
        return false
      end
    end

    def highest_scoring_word
      return Scoring.highest_score_from(@words_played)
    end

    def highest_word_score
      return Scoring.score(highest_scoring_word)
    end

    def tiles
      return @tiles
    end

    def draw_tiles(tilebag)
      number_of_tiles = @tiles.length
      drawn_tiles = tilebag.draw_tiles(7 - number_of_tiles)
      drawn_tiles.each do |letter|
        @tiles << letter
      end
      return drawn_tiles
    end

  end
end
