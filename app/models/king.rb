class King < Piece

  def get_image
    white? ? '&#9812;' : '&#9818;'
  end
  
  def valid_move?(x,y)
    super(x,y) &&
    x_offset(x) <= 1 && y_offset(y) <= 1
  end

  def self_in_check?(x,y) 
    game.pieces.any? { |piece| !piece.white? && piece.valid_move?(x,y)}
  end

end
