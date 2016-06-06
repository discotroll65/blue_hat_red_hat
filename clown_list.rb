require_relative ('clown.rb')

class ClownList
  attr_reader :clowns, :limit_reds, :limit_blues, :num_reds, :num_blues

  def initialize
    @rand_gen = Random.new
    @clowns = []
    @limit_reds =  @rand_gen.rand(100)# < 50 ? :red : :blue
    @limit_blues = 100 - @limit_reds

    @num_reds = 0
    @num_blues = 0

    put_hats_on_clowns
  end



  def [](pos)
    @clowns[pos]
  end

  def length
    @clowns.length
  end

  def dead_clowns
    count = 0
    @clowns.each do |clown|
      count += 1 if !clown.correct
    end
    count
  end

  def correct_clowns
    @clowns.length - dead_clowns
  end

  private
  def can_make_this_hat(color_of_hat)
    if color_of_hat == :red
      return @num_reds < @limit_reds
    else
      return @num_blues < @limit_blues
    end
  end

  def put_hats_on_clowns

    idx = 0
    while @clowns.length < 100 do
      color_of_hat = @rand_gen.rand(100) < 50 ? :red : :blue

      if can_make_this_hat(color_of_hat)
        @clowns.push(
          Clown.new({position: idx, clowns_line: self, color: color_of_hat})
        )

        #increment position for next clown
        idx += 1
        #increment the number of the type of hat we placed
        color_of_hat == :red ? (@num_reds += 1) : (@num_blues += 1)
      end

    end
  end

end
