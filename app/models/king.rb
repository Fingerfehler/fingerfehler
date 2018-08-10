class King < Piece

  def get_image
    white? ? '&#9812;' : '&#9818;'
  end
  
  def valid_move?(x,y)
    super(x,y) &&
    can_move_to?(x,y) &&
    safe?(x,y)
  end

  def can_move_to?(x,y)
    x_offset(x) <= 1 && y_offset(y) <= 1
  end

  def safe?(x,y)
    if white?
      game.black_pieces.none? { |piece| piece.valid_move?(x, y) }
    else
      game.white_pieces.none? { |piece| piece.valid_move?(x, y) }
    end
  end
end
