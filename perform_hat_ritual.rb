require_relative 'clown.rb'
require_relative 'clown_list.rb'

def format(num)
  num.to_s.rjust(2, "0")
end

def play_sick_game
  #get a new list of clowns
  clown_list = ClownList.new

  #make them all guess
  clown_list.clowns.each do |clown|
    heard_result = clown.say_answer

    #all other clowns hear result
    i = clown.pos + 1
    while i < clown_list.length
      clown_list[i].hear_answer_result(heard_result)
      i += 1
    end
  end

  puts "Reds: #{format(clown_list.num_reds)} , Blues: #{format(clown_list.num_blues)}, Correct: #{format(clown_list.correct_clowns)}"
  clown_list.correct_clowns
end


survivors_per_game = []
times_to_play = ARGV[0].to_i
times_to_play.times do |idx|
  survivors_per_game.push(play_sick_game)
end

avg_surviving = survivors_per_game.reduce(:+)/survivors_per_game.length

puts "\nAverage amount of survivors: #{avg_surviving}"
