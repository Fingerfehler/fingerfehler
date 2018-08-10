class King < Piece

  def get_image
    white? ? '&#9812;' : '&#9818;'
  end
  
  def valid_move?(x,y)
    super(x,y) &&
    can_move_to?(x,y) ||
    threatened?(x,y)
  end

  def can_move_to?(x,y)
    x_offset(x) <= 1 && y_offset(y) <= 1
  end

  def threatened?(x,y)
    if white?
      game.black_pieces.any? { |piece| piece.valid_move?(x, y) }
    else
      game.white_pieces.any? { |piece| piece.valid_move?(x, y) }
    end
  end
end
