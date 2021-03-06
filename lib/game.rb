require_relative 'board'
require_relative 'move_requester'
require_relative 'player'

class Game
  def initialize(ui, players)
    @ui = ui
    @player1, @player2 = players
    @board = Board.new
  end

  def run
    output_board
    until @board.game_over?
      run_turn
    end
    end_message
  end

  def game_over?
    @board.game_over?
  end

  private

  def run_turn
    play_move
    output_board
    swap_players
  end

  def swap_players
    @player1, @player2 = @player2, @player1
  end

  def play_move
    move = @player1.move(@board)
    @board = @board.play(move)
  end

  def output_board
    @ui.output(@board.to_s)
  end

  def end_message
    if @board.tie?
      @ui.output('Bravo vous avez fait égalité ! 
                  Vous etes officiellement comme Fred et Georges avant le 7 .')
    else
      @ui.output("Bravo #{@board.winner} Tu l'as détruit.")
    end
  end
end
