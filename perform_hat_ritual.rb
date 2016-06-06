require_relative 'prisoner.rb'
require_relative 'prisoner_list.rb'

def format(num)
  num.to_s.rjust(2, "0")
end

def play_sick_game
  #get a new list of prisoners
  prisoner_list = PrisonerList.new
  
  #make them all guess
  prisoner_list.prisoners.each do |prisoner|
    heard_result = prisoner.say_answer
  
    #all other prisoners hear result 
    i = prisoner.pos + 1
    while i < prisoner_list.length
      prisoner_list[i].hear_answer_result(heard_result)
      i += 1
    end
  end
  
  puts "Reds: #{format(prisoner_list.num_reds)} , Blues: #{format(prisoner_list.num_blues)}, Alive: #{format(prisoner_list.alive_prisoners)}"
  prisoner_list.alive_prisoners
end


survivors_per_game = []
times_to_play = ARGV[0].to_i
times_to_play.times do |idx|
  survivors_per_game.push(play_sick_game)
end

avg_surviving = survivors_per_game.reduce(:+)/survivors_per_game.length

puts "\nAverage amount of survivors: #{avg_surviving}"
