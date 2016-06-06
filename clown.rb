require_relative ('prisoner_list.rb')

class Prisoner
  attr_reader :pos, :color, :alive

  def initialize(opts)
    @pos = opts[:position]
    @alive = true
    @prisoners_line = opts[:prisoners_line]
    @color = opts[:color]


    @known_reds = 0
    @known_blues = 0
    count_hats_ahead
  end

  def say_answer
    answer = figure_what_answer_to_say
    @alive = @color == answer
    {color_spoken: answer, alive: @alive, position: @pos}
  end

  def hear_answer_result(heard_answer)
    #This is also where algorithm code would go!

    @pos_last_heard_answer = heard_answer[:position]
    @last_speaker_alive = heard_answer[:alive]
    @color_last_speaker_said = heard_answer[:color_spoken]
  end

  private

  def figure_what_answer_to_say
    #This is where you put your algorithm!!
    #Make an algorithm that will save the maximum amount of people for sure

    @known_reds > @known_blues ? :red : :blue
  end

  def count_hats_ahead
    i = pos + 1
    while i < @prisoners_line.length
      seen_color = prisoners_line[i].color
      if seen_color == :red
        @known_reds += 1 
      else
        @known_blues += 1
      end
      i += 1
    end
  end

end

