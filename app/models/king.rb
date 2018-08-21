class King < Piece

  def get_image
    white? ? '&#9812;' : '&#9818;'
  end
  
  def valid_move?(x,y)
    is_unobstructed?(x,y) &&
    super(x,y) &&
    can_move_to?(x,y) &&
    safe?(x,y)
  end

  def can_move_to?(x,y)
    x_offset(x) <= 1 && y_offset(y) <= 1
  end

  def can_castle?(x,y)
    has_not_moved? && y == y_coord && rook_present?(x,y) && game.piece_at(x,y).has_not_moved? && is_unobstructed?(x,y)
  end

  def castle!(x,y)
    update_coords!(x_coord + castling_displacement(x,y), y)
    self.move_count += 1
  end

  def castling_displacement(x,y)
    x > x_coord ? 2 : -2
  end

  def rook_present?(x,y)
    game.piece_at(x,y).is_a? Rook
  end

  def safe?(x,y)
    if white?
      game.black_pieces.none? { |piece| piece.valid_move?(x, y) }
    else
      game.white_pieces.none? { |piece| piece.valid_move?(x, y) }
    end
  end

end
