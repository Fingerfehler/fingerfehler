class Rook < Piece
  def get_image
    if white?
      '&#9814;'
    else
      '&#9820;'
    end
  end

  def valid_move(x,y)
    return false unless super(x,y)
    (y_coord - y) == 0 ||
    (x_coord - x) == 0
  end 

end
