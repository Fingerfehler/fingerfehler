class Rook < Piece
  def get_image
    if white?
      '&#9814;'
    else
      '&#9820;'
    end
  end

  def valid_move?(x,y)
    return false unless super(x,y)
    y == y_coord && x != x_coord ||
    x == x_coord && y != y_coord 
  end 

end
