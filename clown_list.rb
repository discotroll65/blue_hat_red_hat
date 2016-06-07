require_relative ('clown.rb')

class ClownList
  attr_reader :clowns, :limit_reds, :limit_blues, :num_reds, :num_blues

  def initialize
    @rand_gen = Random.new
    @clowns = []
    @clowns_hash_array = []
    @limit_reds =  @rand_gen.rand(100)# < 50 ? :red : :blue
    @limit_blues = 100 - @limit_reds

    @num_reds = 0
    @num_blues = 0

    put_hats_on_clowns
  end

  def length
    @clowns.length
  end

  def num_color(color)
    @clowns_hash_array.select{ |clown_hash| clown_hash[:color_of_hat] == color }.count
  end

  def correct_clowns
    @clowns_hash_array.select{ |clown_hash| clown_hash[:color_of_hat] == clown_hash[:guessed_color_of_hat] }.count
  end

  def previous_answers(clown)
    return @clowns_hash_array[0..(clown_index(clown) - 1)].map{ |clown_hash| clown_hash[:guessed_color_of_hat] }
  end

  def future_colors(clown)
    return @clowns_hash_array[((clown_index(clown)) + 1)..-1].map{ |clown_hash| clown_hash[:color_of_hat] }
  end

  def clown_guesses(clown, color)
    @clowns_hash_array[clown_index(clown)][:guessed_color_of_hat] = color
  end

  private

  def [](pos)
    @clowns[pos]
  end

  def clown_index(clown)
    @clowns.index(clown)
  end

  def can_make_this_hat(color_of_hat)
    if color_of_hat == :red
      return @num_reds < @limit_reds
    else
      return @num_blues < @limit_blues
    end
  end

  def put_hats_on_clowns

    100.times do
      color_of_hat = @rand_gen.rand(100) < 50 ? :red : :blue

      if !can_make_this_hat(color_of_hat)
        if color_of_hat == :red
          color_of_hat = :blue
        else
          color_of_hat = :red
        end
      end
      @clowns << Clown.new(self)
      @clowns_hash_array << {color_of_hat: color_of_hat}

      #increment the number of the type of hat we placed
      color_of_hat == :red ? (@num_reds += 1) : (@num_blues += 1)

    end
  end

end
