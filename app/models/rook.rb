class Rook < Piece

  def get_image
    white? ? '&#9814;' : '&#9820;'
  end

  def valid_move?(x,y)
    return unless is_unobstructed?(x,y)
    super(x,y) &&
    x_offset(x) == 0 || y_offset(y) == 0
  end 

  def can_castle?
    king_starting_square = game.piece_at(4, y_coord)
    if king_starting_square.is_a? King
      king_starting_square.can_castle?(x_coord, y_coord)
    else
      false
    end
  end

  def castle!
    move_to!(x_coord + castling_displacement, y_coord)
  end

  def castling_displacement
    x_coord == 0 ? 3 : -2
  end

end
