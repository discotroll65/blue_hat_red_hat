require_relative ('prisoner.rb')

class PrisonerList
  attr_reader :prisoners, :limit_reds, :limit_blues, :num_reds, :num_blues

  def initialize
    @rand_gen = Random.new
    @prisoners = []
    @limit_reds =  @rand_gen.rand(100)# < 50 ? :red : :blue
    @limit_blues = 100 - @limit_reds

    @num_reds = 0
    @num_blues = 0
    
    put_hats_on_prisoners
  end



  def [](pos)
    @prisoners[pos]
  end
  
  def length
    @prisoners.length
  end

  def dead_prisoners
    count = 0
    @prisoners.each do |prisoner|
      count += 1 if !prisoner.alive
    end
    count
  end

  def alive_prisoners
    @prisoners.length - dead_prisoners
  end
  
  private
  def can_make_this_hat(color_of_hat)
    if color_of_hat == :red
      return @num_reds < @limit_reds
    else
      return @num_blues < @limit_blues 
    end
  end

  def put_hats_on_prisoners

    idx = 0
    while @prisoners.length < 100 do 
      color_of_hat = @rand_gen.rand(100) < 50 ? :red : :blue 

      if can_make_this_hat(color_of_hat) 
        @prisoners.push(
          Prisoner.new({position: idx, prisoners_line: self, color: color_of_hat})
        )

        #increment position for next prisoner 
        idx += 1 
        #increment the number of the type of hat we placed
        color_of_hat == :red ? (@num_reds += 1) : (@num_blues += 1)
      end
      
    end
  end

end
