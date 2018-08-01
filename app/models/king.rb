class King < Piece

  def get_image
    white? ? '&#9812;' : '&#9818;'
  end
  
  def valid_move?(x,y)
    return false unless super(x,y)
    (y - y_coord).abs <= 1 && (x - x_coord).abs <= 1
  end

  def can_castle?(x,y)
    has_not_moved? && y == y_coord && piece_on_square(x,y).is_a? Rook && piece_on_square(x,y).has_not_moved? && is_unobstructed?(x,y)
  end

  def castle!(x,y)
    move_to!(x_coord + (2 * castling_direction(x,y)), y) if can_castle?(x,y)
  end

  def castling_direction(x,y)
    x > x_coord ? 1 : -1
  end

end

