class Piece < ApplicationRecord
  belongs_to :game

  def is_obstructed?(x, y)

  end

  def is_horizontally_obstructed?(x, y)
    raise "y coordinates of squares must be the same" unless y_coord == y 
    raise "x coordinates of squares cannot be the same" if x_coord == x 
    x1 = [x, x_coord].min + 1
    x2 = [x, x_coord].max
    raise "squares cannot be adjacent" if x1 == x2 
    squares_to_check = (x1...x2).map { |x| [x, y] }
    self.game.pieces.each do |piece|
      squares_to_check.each do |square|
        return true if piece.x_coord == square[0] && piece.y_coord == square[1]
      end
    end
    return false
  end

  def is_vertically_obstructed?(x, y)

  end

  def is_diagonally_obstructed?(x, y)

  end
end
