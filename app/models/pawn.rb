class Pawn < Piece

  def get_image
    if white?
      '&#9817;'
    else
      '&#9823;'
    end
  end

  def valid_move?(x,y)
    if super(x,y)
      movement_direction = white? ? 1 : -1
      # standard movement
      if x == x_coord && square_is_vacant?(x,y)
        return true if (y == y_coord + movement_direction)
        return true if (y == y_coord + (2 * movement_direction)) && self.has_not_moved?
      end
      # diagonal capture movement
      return true if (x - x_coord).abs == 1 && (y == y_coord + movement_direction) && opponent_on_square?(x,y)
    end
    false
  end

end
