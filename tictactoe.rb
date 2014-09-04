require 'pry'


def draw_board(board)
  puts "    |     |     "
  puts " #{board[0]}  |  #{board[1]}  |  #{board[2]}  "
  puts "    |     |     "
  puts "----+-----+-----"
  puts "    |     |     "
  puts" #{board[3]}  |  #{board[4]}  |  #{board[5]}  "
  puts "    |     |     "
  puts "----+-----+-----"
  puts "    |     |     "
  puts" #{board[6]}  |  #{board[7]}  |  #{board[8]}  "
  puts "    |     |     "
end

def player_pick(board)
  loop do
    puts "Pick a square (1 - 9):"
    player1_pick = gets.chomp.to_i
    if player1_pick > 9 || player1_pick < 1
      puts "Sorry, please pick a number 1 - 9"
    elsif board.include?(player1_pick)
      board[player1_pick-1] = "X"
      return board
    else
      puts "Sorry, that number is already taken. Please try again."
    end
  end    
end

def computer_pick(board)
  available_board = board.select { |num| num.is_a? Integer }
  if available_board.empty?
    
  else
    comp_pick = available_board.sample
    board[comp_pick-1] = "O"
    return board
  end
end

def all_squares_taken?(board, score)
  full = 9
  board.each do |num|
    if num == "X" || num == "O"
      full -= 1
    end
  end
  if full == 0
    puts "Nobody won! Try again!!!"
    score[:tie] += 1
    return true
  else
    return false
  end
end

def winner(board, score)
  winning_lines = [ [1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7] ]

  winning_lines.each do |win|
    win_sum = 0

    # Do another iterator over each number in each win
    win.each do |num|
      if board[num-1] == "O"
        win_sum += 1
      elsif board[num-1] == "X"
        win_sum -= 1
      end
    end

    # Check if there is a winner
   if win_sum == 3
      puts "The Computer wins!!!"
      score[:comp] += 1
      return true
      break
    elsif win_sum == -3
      puts "You beat the computer!!!"
      score[:user] += 1
      return true
      break
    end  
  end

  #Return false if the iterator doesn't find a winner
  return false
    
end

def puts_score(hash)
  puts "The score is Computer: #{hash[:comp]}, You: #{hash[:user]}, Tie: #{hash[:tie]}"
end

#Initialize board
board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
draw_board(board)
score = {user: 0, comp: 0, tie: 0}

def play(board, score)
  begin
    player_pick(board)
    computer_pick(board)
    draw_board(board)
  end until winner(board, score) || all_squares_taken?(board, score)
  puts_score(score)
end

loop do
  play(board, score)
  puts "Do you want to play again? (Y/N)"
  answer = gets.chomp.to_s.upcase
  if answer == "Y" || answer == "YES"
    board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    draw_board(board)
    next
  else
    puts "The final score is Computer: #{score[:comp]}, You: #{score[:user]}, Tie: #{score[:tie]}"
    break
  end

end