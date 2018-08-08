class King < Piece

  def get_image
    white? ? '&#9812;' : '&#9818;'
  end
  
  def valid_move?(x,y)
    super(x,y) &&
    x_offset(x) <= 1 && y_offset(y) <= 1
  end

  def can_castle?(x,y)
    has_not_moved? && y == y_coord && rook_present?(x,y) && game.piece_at(x,y).has_not_moved? && is_unobstructed?(x,y)
  end

  def castle!(x,y)
    move_to!(x_coord + castling_displacement(x,y), y)
  end

  def castling_displacement(x,y)
    x > x_coord ? 2 : -2
  end

  def rook_present?(x,y)
    game.piece_at(x,y).is_a? Rook
  end

end
