class King < Piece

  def get_image
    white? ? '&#9812;' : '&#9818;'
  end
  
  def valid_move?(x,y)
    return false unless super(x,y)
    (y - y_coord).abs <= 1 && (x - x_coord).abs <= 1
  end

  def can_castle?(x,y)
    has_not_moved? && y == y_coord && is_rook?(x,y) && game.piece_at(x,y).has_not_moved? && is_unobstructed?(x,y)
  end

  def castle!(x,y)
    move_to!(x_coord + castling_displacement(x,y), y) if can_castle?(x,y)
  end

  def castling_displacement(x,y)
    x > x_coord ? 2 : -2
  end

  def is_rook?(x,y)
    game.piece_at(x,y).is_a? Rook
  end

end

