require_relative ('clown_list.rb')

class Clown
  attr_reader :pos, :color, :correct

  def initialize(line)
    @clowns_line = line
  end

  def say_answer
    answer = figure_what_answer_to_say
  end

  private

  def figure_what_answer_to_say
    #This is where you put your algorithm!!
    #Make an algorithm that will save the maximum amount of people for sure

    known_red > known_blue ? :red : :blue
  end

  def known_red
    @clowns_line.future_colors(self).count{|color| color == :red}
  end

  def known_blue
    @clowns_line.future_colors(self).count{|color| color == :blue}
  end

  def heard_red
    @clowns_line.previous_answers(self).count{|color| color == :red}
  end

  def heard_blue
    @clowns_line.previous_answers(self).count{|color| color == :blue}
  end

end
